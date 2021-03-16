# Mentoring

## Reasonable solution

This is a nice, concise, efficient solution:

```r
sum_of_multiples <- function(factors, limit) {
  func <- function(x) { seq(0, limit - 1, x) }
  sum(unique(unlist(lapply(factors, func))))
}
```

## Common suggestions

- Point learners who use a `for` loop to the alternative `apply` or `map` function families
    + For example, explained by one of these:
        * `[How to Avoid For Loop in R](https://statcompute.wordpress.com/2018/09/15/how-to-avoid-for-loop-in-r/)`
        * `[For loops vs. functionals](https://r4ds.had.co.nz/iteration.html#for-loops-vs.functionals)`
        * `[Happy R Users Purrr](https://www.rstudio.com/resources/videos/happy-r-users-purrr-tutorial/)`
        * `[What is Vectorization?](https://www.datacamp.com/community/tutorials/tutorial-on-loops-in-r#the-alternatives-to-loops-in-r)`
    + Performance benefit esp. for larger input vectors.
    + The code's intention can be expressed better by a better `func` name.


## Talking points

`microbenchmark` can be used to compare the performance of different function variants, which in turn should support the argument that a `for` loop falls behind for large vectors.

```r
microbenchmark(
  sum_of_multiples_old(1:100, 10^4),
  sum_of_multiples_new(1:100, 10^4)
)
```
