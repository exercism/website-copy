# Example solutions

`````

Docstring:

````julia
"""
    wordcount(input)

Find the frequency of each term in the input.

## Example

```jldoctest
julia> wordcount("Joe can't tell between 'large' and large.")
Dict{String,Int64} with 6 entries:
  "tell"    => 1
  "can't"   => 1
  "large"   => 2
  "joe"     => 1
  "between" => 1
  "and"     => 1
```
"""
````

**Split, then strip quotation**

This solution, like all the others below uses "Regex".
Regex is a concise language for describing patterns in strings.

In Julia, `r"foo"` constructs a Regex at compilation time using the `@r_str` macro.

```julia
function wordcount(input)
    words = split(input, r"[^\w']+")
    counts = Dict{String, Int}()
    for word in words
        # Removing leading and closing apostrophes (might be quotation)
        word = lowercase(strip(word, '''))
        if !isempty(word)
            counts[word] = get(counts, word, 0) + 1
        end
    end
    return counts
end
```

This solution uses a regex, but you could equally do something like:

```julia
split(input, c -> !(isalnum(c) || c == '''); keepempty=false)
```

Using `keepempty` because unlike the Regex (which can match many characters at once), this would return many empty strings for long runs of whitespace or punctuation.

**Find each word with regex without splitting the input**

This is a straightforward algorithm and it is easy to prove that it follows the specification exactly.
Implementations that split by whitespace and punctuation tend to count words that the specification does not ask for, e.g. "x1".
You can view that as a good thing or a bad thing!
For what it is worth, traditional word counting code like `wc` treat a mix of letters and digits as a word.

```julia
function wordcount(input)
    counts = Dict{String, Int}()
    # Unicode version matching any letters or numbers: r"\pL+'\pL|\pL+|\pN+"
    for m in eachmatch(r"[A-Za-z]+'[A-Za-z]|[A-Za-z]+|[0-9]+", input)
        word = lowercase(m.match)
        counts[word] = get(counts, word, 0) + 1
    end
    return counts
end
```

Same as above, but we lowercase `input` all in one go, so we can have a `Dict` of `SubString`s, which is slightly faster and might be better for some purposes.

```julia
function wordcount(input)
    counts = Dict{SubString{typeof(input)}, Int}()
    # Unicode version matching any letters or numbers: r"\pL+'\pL|\pL+|\pN+"
    for m in eachmatch(r"[A-Za-z]+'[A-Za-z]|[A-Za-z]+|[0-9]+", lowercase(input))
        word = m.match
        counts[word] = get(counts, word, 0) + 1
    end
    return counts
end
```


**Curios**

This solution uses some clever matching to find apostrophes that aren't contractions, then splits.
It's important to match word boundaries because otherwise the code doesn't handle apostrophes at the start or end of the string correctly.
Inspired by mentoring rezaeir's solution.

If you don't know what a "word-boundary" is in regex,
[this stack overflow post might help](https://stackoverflow.com/questions/4541573/what-are-non-word-boundary-in-regex-b-compared-to-word-boundary)
(Note, though that character classes in Julia Regexes include unicode characters by default. e.g. `\w` matches `[\pL\pN_]` (all characters that are letters or numbers, and underscore). Search the PCRE `man` page for `PCRE_UCP` for more information).

```julia
function wordcount(sentence)
    # ' can be used inside a contracted word or for
    # quotation. We want to remove all ' that are not
    # used in words.
    #
    # Remove all ' that have a non-word-boundary on
    # at least one side.
    sentence = replace(sentence, r"'\B|\B'" => "")

    # Split into lowercase words:
    words = split(lowercase(sentence), r"[^\w']+", keepempty=false)

    counts = Dict{eltype(words), Int}()
    for word in words
        counts[word] = get(counts, word, 0) + 1
    end

    return counts
end
```

** Without Regex ** 

This solution doesn't use a regex at all. It uses the default split behavior (which checks for `isspace` characters) and then strips punctuation characters left over on the "outside" of words. Filtering hoas to come after stripping in case the strip operation itself left an empty string.
```julia
function wordcount(sentence)
    words = strip.(ispunct, split(lowercase(sentence)))
    filter!(!isempty, words)
    d = Dict{eltype(words), Int}()
    for w in words
        d[w] = get(d, w, 0) + 1
    end
    d
end
```
It's possible to create the dictionary more efficiently with the `countmap` function from `StatsBase` (which only hashes the key once per check). With countmap, you can code-golf the above into:
```julia
using StatsBase: countmap

wordcount_withstatsbase(sentence) = countmap(filter!(!isempty, strip.(ispunct, split(lowercase(sentence)))))
```


** Totally manual ** 

This method iterates through the string one character at a time and switches behavior at word boundaries (when `iswordchar` changes from true to false or false to true). The dictionary has `SubString` keys in this version, which are like the string-version of Array `views`.
```julia
function wordcount(sent)

    sent = lowercase(sent)
    d = Dict{SubString, Int}()

    in_word = false; j = 0
    # For our purposes, almost everything is a valid word character.
    iswordchar(c) = !ispunct(c) && !isspace(c)
    for i in eachindex(sent)
        c = sent[i]
        if iswordchar(c) && i < lastindex(sent)
            # if we're not already in a word, then this character marks
            # the start of a new word. If we are in a word, just keep going.
            if !in_word
                in_word = true
                j = i
            end
        elseif in_word
            # If this character is not a word character, but we are in a word,
            # then the previous character marks the end of a word. However, if the
            # current character is a ' we need to see if this word is a contraction
            if c == '''
                i < lastindex(sent) && iswordchar(sent[nextind(sent, i)]) && continue
            end

            in_word = false
            k = SubString(sent, j:(i-1))
            d[k] = get(d, k, 0) + 1
        end
    end
    d
end
```

### Benchmark comparison in julia v1.5.1
** methods named in order of appearance in this doc ** 
```julia
julia> for wordcounter in (wordcount1, wordcount2, wordcount3, wordcount4, wordcount5, wordcount6)
           println(wordcounter)
           @btime $wordcounter("Joe can't tell between 'large' and large.")
           @btime $wordcounter($("Joe can't tell between 'large' and large."^60))
       end
wordcount1
  4.179 μs (30 allocations: 1.95 KiB)
  226.513 μs (1275 allocations: 77.55 KiB)
wordcount2
  3.642 μs (46 allocations: 3.00 KiB)
  209.253 μs (2524 allocations: 144.97 KiB)
wordcount3
  3.043 μs (28 allocations: 2.64 KiB)
  168.612 μs (1267 allocations: 100.25 KiB)
wordcount4
  3.440 μs (14 allocations: 1.75 KiB)
  158.446 μs (20 allocations: 35.55 KiB)
wordcount5
  2.653 μs (11 allocations: 1.75 KiB)
  121.197 μs (587 allocations: 50.27 KiB)
wordcount_withstatsbase
  2.471 μs (11 allocations: 1.75 KiB)
  108.857 μs (587 allocations: 50.27 KiB)
wordcount6
  2.105 μs (18 allocations: 1.17 KiB)
  139.380 μs (1375 allocations: 50.84 KiB)
```


`````
