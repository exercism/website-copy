# Mentoring

### Reasonable solution

This solution is clear, robust, and extremely concise.

```r
convert_ascii <- function(value, key){
  if ((value >= 97) && (value <= 122)){
    return(97 + (value + key - 97) %% 26)
  } 
  if ((value >= 65) && (value <= 90)){
    return(65 + (value + key - 65) %% 26)
  } 
  value
}

rotate <- function(text, key) {
  text %>% 
    utf8ToInt() %>% 
    sapply(convert_ascii, key) %>% 
    intToUtf8()
}
```

### Common suggestions

- The example above could be improved by replacing "magic numbers" like `65` with variables or expressions such as `utf8ToInt('a')` to define the lower and upper-case bounds, and so that future coders know what the number is defining.
- Make sure that the key cannot exceed the bounds of whatever the student is using as a mapping variable. For example, if the student is simply using the base variable `letters` as a map, ensure that the key is modulo divided (`%%`) by the length of `letters` so index errors don't arise.
- Point learners towards functions like `utf8ToInt` and `intToUtf8` to make their solution more robust than hard-coded indices.
