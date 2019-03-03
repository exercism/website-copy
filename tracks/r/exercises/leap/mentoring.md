### Reasonable solutions

A nice, concise, efficient solution can be found in [`example.R`](https://github.com/exercism/r/blob/master/exercises/leap/example.R).


### Common suggestions
- there are just two cases that return True:
- a year is a multiple of 4 *and not* 100
- a year is a multiple of 4, 100, and 400
- For students interested in optimization, order of operations matter:
- 75% of all years *cannot* be leap years because they are not mulitples of 4; test `year % 4 == 0` first
- 98.97% of all years that are multiples of 4 are not multiples of 100; test `year % 100 != 0` second
- 1.03% of all years that are multiples of 4 are also multiples of 100 and 400; test `year % 400 == 0` third
- and order of evaluation matters:
```r
year %% 4 == 0 & year %% 100 != 0 | year %% 400 == 0
```
_looks_ right, but will force a year like 999 to be checked for being a multiple of 400 unnecessarily
- eliminate duplicate work; no year should ever have to be checked multiple times for the same condition


### Talking points

It's probably too early in the track to introduce the concept of vectorized functions, but worth mentioning here in case it comes up. Using `&&` instead of `&` and `||` instead of `|` is still correct if the input year can be assumed to be a scalar. But use of the vectorized `&` and `|` is preferable since this will yield a vectorized solution.
