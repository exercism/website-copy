# Mentoring

## Reasonable solution

This solution is easy to follow, has minimal re-assignments, and uses conditional logic in such a way to make the code more readable.

```r
bob <- function(input) {
  trimmed_input <- trimws(input)

  is_shouted_statement <- is_shouting(trimmed_input)
  is_question_statement <- is_question(trimmed_input)

  if (nchar(trimmed_input) == 0) {
    "Fine. Be that way!"
  } else if (is_shouted_statement && is_question_statement) {
    "Calm down, I know what I'm doing!"
  } else if (is_question_statement) {
    "Sure."
  } else if (is_shouted_statement) {
    "Whoa, chill out!"
  } else {
    "Whatever."
  }
}

is_question <- function(statement) { grepl("\\?$", statement) }
is_shouting <- function(statement) { grepl("^[A-Z]+$", letters_only(statement)) }
letters_only <- function(string) { gsub("[^a-zA-Z]", "", string) }
```

The learning goal here is to get comfortable with regular-expressions, pattern matching, and common string operations. Secondarily, having students check multiple conditions in an orderly fashion bolsters their conditional flow control.

## Common suggestions

- If a student uses dense conditional statements, readability can easily be degraded.
- If a student uses a Boolean vector for indexing, so too can readability decrease (although decent examples exist, like the one below). Have students try to make their answer as intelligible as possible.
- If students are performing the same operations on `input` in their if statements, suggest that they create a variable instead, so the computer doesn't have to do more work than necessary.
- If they use explicit `return` commands, discuss how R returns values from a function and suggest they remove the explicit returns.

## Talking points

An advanced solution might look like one below, where indexing is used instead of if statements. Notice that readability is decreased, but the ordering of the conditions checked is identical.

```r
responses <- c("Fine. Be that way!", "Calm down, I know what I'm doing!",
               "Sure.", "Whoa, chill out!", "Whatever.")

bob <- function(input) {
  trim <- trimws(input)

  huh <- endsWith(trim, "?")
  yell <- (trim == toupper(trim)) && (trim != tolower(trim))

  tests <- c(!nchar(trim), (huh && yell), huh, yell, T)
  responses[tests][1]
}
```
