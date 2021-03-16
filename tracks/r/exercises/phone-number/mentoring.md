# Mentoring

## Reasonable solution

This is a straight-forward, logical solution:

```r
parse_phone_number <- function(number_string) {
  number_string <- gsub("[^[:digit:]]", "", number_string)

  digits <- nchar(number_string)
  if (digits < 10 || digits > 11)
    return(NULL)
  if (digits == 11) {
    if (!grepl("^1", number_string)) {
      return(NULL)
    } else {
      number_string <- substr(number_string, 2, 11)
    }
  }

  if (!grepl("^[2-9].{2}[2-9]", number_string)) {
    return(NULL)
  }

  return(number_string)
}
```

## Common suggestions

- Same as the Word Count exercise, `[regex](https://regexr.com/)` is a great resource for visualizing regular expression pattern matching.
- Emphasize the `grep`, `gsub`, and `gregexpr` family of functions. As with the solution above, most of the conditional logic can be replaced with keen pattern matching.


## Talking points

A solution heavy on pattern-matching might look like this:
```r
parse_phone_number <- function(number_string) {
  only_numbers <- gsub("\\D" , "", number_string)
  no_area_code <- gsub("^1", "", only_numbers)
  
  valid_length <- nchar(no_area_code) == 10
  valid_ex_sub <- grepl("[2-9]\\d{2}[2-9]\\d{6}", no_area_code)
  
  if (valid_length && valid_ex_sub) { no_area_code }
  else { NULL }
}
```

But beware! A complex pattern can start to hinder readability.
```r
parse_phone_number <- function(number_string) {
  digits <- gsub("[^0-9]", "", number_string)

  m <- regexec(
    "(?x) ^1? ((?: [2-9][0-9]{2} ){2} [0-9]{4}) $",
    digits,
    perl = TRUE
  )
  if (m[[1]][1] != -1) regmatches(digits, m)[[1]][2]
}
```
