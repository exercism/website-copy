# Mentoring

## Reasonable solution

This is a nice, concise, efficient solution:

```r
leap <- function(year) {
  year %% 4 == 0 & (year %% 100 != 0 | year %% 400 == 0)
}
```

## Common suggestions

- There are just two cases that return `TRUE`:
    1. A year is a multiple of 4 *and not* 100.
    2. A year is a multiple of 4, 100, and 400.
- For students interested in optimization, order of operations matter:
    1. 75% of all years *cannot* be leap years because they are not multiples of 4; test `year % 4 == 0` first.
    2. 98.97% of all leap years are multiples of 4 that are not multiples of 100; test `year % 100 != 0` second.
    3. 1.03% of all leap years are multiples of 4 that are also multiples of 100 and 400; test `year % 400 == 0` third.
- Order of evaluation matters:
```r
year %% 4 == 0 & year %% 100 != 0 | year %% 400 == 0
```
_looks_ right, but will force a year like 999 to be checked for being a multiple of 400 unnecessarily.
- Eliminate duplicate work; no year should ever have to be checked multiple times for the same condition.


## Talking points

It's probably too early in the track to introduce the concept of vectorized functions, but worth mentioning here in case it comes up. Using `&&` instead of `&` and `||` instead of `|` is still correct if the input year can be assumed to be a scalar. But use of the vectorized `&` and `|` is preferable since this will yield a vectorized solution.
