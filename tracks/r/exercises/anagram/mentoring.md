# Mentoring

## Reasonable solution

This solution is clear and straight-forward.

```r
anagram <- function(subject, candidates) {
  
  subject_letters <- tolower(strsplit(subject, "")[[1]])
  target <- sort(subject_letters)

  is_anagram <- function(word) {
    word_letters <- tolower(strsplit(word, "")[[1]])
    identical(sort(word_letters), target) && !identical(word_letters, subject_letters)
  }
  
  matches <- sapply(candidates, is_anagram)

  if(!any(matches)) {
    c()
  } else {
    candidates[matches]
  }
}
```

The learning goal here is common string operations and checking conditions on strings vs. on a per character level.

## Common suggestions

- Depending on what the student chooses to do, explain how `identical()` differs from `==`; or how `all()` and `any()` can be used in combination with comparison operators to arrive at the same solution. This can help if students are stuck on why they're not getting a single Boolean back from comparisons on vectors.
- If the solution looks like the one above, consider discussing the pros and cons of having a nested function (e.g. `is_anagram`) vs. one that is independent from `anagram()`. Remember that the `apply()` function-family can take in additional parameters like `target` and `subject_letters` if the applied function needs to receive more than one parameter.

## Talking points

A different flavor of solution:

```r
split_sort <- function(x) {
  paste(sort(unlist(strsplit(tolower(x), ""))), collapse="")
}

anagram <- function(subject, candidates) {
  not_equiv <- !grepl(subject, candidates, ignore.case=TRUE)
  is_ana <- sapply(candidates, split_sort) == split_sort(subject)

  result <- candidates[not_equiv & is_ana]
  
  if (identical(result, character(0))) {
    c()
  } else {
    result
  }
}
```

... The use of `grepl()` is encouraged for its performance benefits. Otherwise, most of the same logic is applied in this solution as in the reasonable solution.
