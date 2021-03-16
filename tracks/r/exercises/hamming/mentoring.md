# Mentoring

### Reasonable solution

A concise solution will have the following elements:

```r
hamming <- function(strand1, strand2) {
  if (nchar(strand1) != nchar(strand2))
    stop("Strands of differing lengths don't compute!")
  
  bases1 <- strsplit(strand1, split = ""))[[1]]
  # or alternatively:
  bases2 <- unlist(strsplit(strand2, split = NULL))
  
  sum(bases1 != bases2)
}
```

### Common suggestions

- Point learners who use _many_ intermediate variables, or even a dataframe, or an accumulator(-like) pattern …
```r
distance <- 0
for (i in 1:length(bases1)) {
  if (bases1[i] != bases2[i])
        distance <- distance + 1
}
```
… to the equivalence of `TRUE` & `FALSE` with `1` & `0`. Therefore, `sum()` can be
used on the result of the vector comparison directly.
- Customising the error in `if(…) stop('message')` may be desirable in real-world situations,
but this also shifts the burden of formulating a useful message to the developer.
`stopifnot(… == …)` is more compact, and in case of an error, prints the exact comparison
and its result.

### Talking points

This exercise can be the starting point of using the [tidyverse](https://tidyverse.org):
`strsplit(…)` [`%>%`](https://magrittr.tidyverse.org) `unlist()` avoids function nesting
or intermediate variables. This makes longer code blocks (e.g. of data analysis
pipelines) more readable, but decreases performance.
