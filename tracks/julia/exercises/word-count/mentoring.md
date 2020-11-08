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

This solution, like all the others below uses "regex".
Regex is a concise language for describing patterns in strings.

In Julia, `r"foo"` constructs a `Regex` object at compilation time using the `@r_str` macro.

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
split(input, c -> !(isletter(c) || isdigit(c) || c == '''); keepempty=false)
```

Using `keepempty` because unlike the regex (which can match many characters at once), this would return many empty strings for long runs of whitespace or punctuation.

**Find each word with regex without splitting the input**

This is a straightforward algorithm and it is easy to prove that it follows the specification exactly.
Implementations that split by whitespace and punctuation tend to count words that the specification does not ask for, e.g. "x1".
You can view that as a good thing or a bad thing!
For what it is worth, traditional word counting code like `wc` treat a mix of letters and digits as a word.

```julia
function wordcount(input)
    counts = Dict{String, Int}()
    # Unicode version matching any letters or numbers: r"\pL+'\pL+|\pL+|\pN+"
    for m in eachmatch(r"[A-Za-z]+'[A-Za-z]+|[A-Za-z]+|[0-9]+", input)
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
    # Unicode version matching any letters or numbers: r"\pL+'\pL+|\pL+|\pN+"
    for m in eachmatch(r"[A-Za-z]+'[A-Za-z]+|[A-Za-z]+|[0-9]+", lowercase(input))
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
(Note, though that character classes in Julia regexes include unicode characters by default. e.g. `\w` matches `[\pL\pN_]` (all characters that are letters or numbers, and underscore). Search the PCRE `man` page for `PCRE_UCP` for more information).

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

`````
