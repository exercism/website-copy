### Reasonable solutions

This is a nice, concise, efficient solution:

```r
sum_of_multiples <- function(factors, limit) {
  func <- function(x) seq(0, limit - 1, x)
  sum(unique(unlist(lapply(factors, func))))
}
```


### Common suggestions

- point learners who use a `for` loop to the alternative `apply` or `map` function families
    + for example explained by one of these:
        * https://statcompute.wordpress.com/2018/09/15/how-to-avoid-for-loop-in-r/
        * https://r4ds.had.co.nz/iteration.html#for-loops-vs.functionals
        * https://www.rstudio.com/resources/videos/happy-r-users-purrr-tutorial/
        * https://www.datacamp.com/community/tutorials/tutorial-on-loops-in-r#the-alternatives-to-loops-in-r
    + performance benefit esp. for larger input vectors
    + the code's intention can be expressed better by a better `func` name

### Talking points

`microbenchmark`ing can be used to compare the performance of different function variants, which in turn should support the argument that a `for` loop falls behind for large vectors.

```r
microbenchmark(
  sum_of_multiples_old(1:100, 10^4),
  sum_of_multiples_new(1:100, 10^4)
)
```
