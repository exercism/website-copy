# Mentoring

## Reasonable solution

This solution is simple and follows a logical thought process.

```r
word_count <- function(input) {
  input_no_punctuation <- gsub('[[:punct:]]+','',input)
  input_no_whitespace <- gsub('\\s+', ' ', trimws(input_no_punctuation))
  words <- unlist(strsplit(tolower(input_no_whitespace), ' '))
  return(as.list(table(words)))
}
```

## Common suggestions

- For general help with regular-expressions, `[regex](https://regexr.com/)` is a wonderful website for visualizing what a pattern is capturing.
- `strsplit` is able to use patterns just like `gsub` and `grep`. Using `'\\s+'` in the call to `strsplit` can save the call to `gsub` above it.
- If there was a test for words separated by commas, e.g. `"one,two,three"`, it'd be best to have a solution that could handle it. Don't be afraid to think about more tests that _could_ be accounted for.

## Talking points

- `sapply(unique(str), function(x) sum(str == x))` and similar code can be used to replace `table`, but is far less elegant / efficient.
- It doesn't get much more concise than this:
```r
word_count <- function(input) {
  input <- gsub("[^[:alnum:][:blank:]]", "", tolower(input))
  return(as.list(table(scan(text=input, what=''))))
}
```
