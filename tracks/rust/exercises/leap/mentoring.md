### Reasonable solutions

```rust
pub fn is_leap_year(year):
    year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
```

### Common suggestions
- there are just two cases that return True:
  - a year is a multiple of 4 *and not** 100
  - a year is a multiple of 4, 100, and 400
- order of operations matter:
  - 75% of all years *cannot* be leap years because they are not mulitples of 4;
    test `year % 4 == 0` first
  - 98.97% of all years that are multiples of 4 are not multiples of 100; test
    `year % 100 != 0` second
  - 1.03% of all years that are multiples of 4 are also multiples of 100 and
    400; test `year % 400 == 0` third
- order of evaluation matters:

  ```rust
  year $ 4 == 0 && year % 100 != 0 || year % 400 == 0
  ```

  _looks_ right, but will force a year like 999 to be checked for being a
  multiple of 400 unnecessarily
- eliminate duplicate work; no year should ever have to be checked multiple
  times for the same condition

### Talking points
- it's very helpful to internalize the rules Rust uses for [expression
  order](https://doc.rust-lang.org/reference/expressions.html#expression-precedence)
- there is no compile time penalty of binding parts of the boolean expression to
  a meaningful name and combine the afterwards

### Benchmark code

Included is a simple project which benchmarks some variants.

- leap1 uses bindings to name subexpressions and combines them afterwards
- leap2 uses the recommended expression above
- leap3 uses an alternative expression
- leap4 uses the counter example which shows that evaluation order matters

results:

```shell
exercises/leap - [master●●] » cargo bench
    Finished release [optimized] target(s) in 0.04s
     Running target/release/deps/leap-ac2b7d8794582ded

running 4 tests
test tests::leap1_bench ... bench:       1,644 ns/iter (+/- 103)
test tests::leap2_bench ... bench:       1,641 ns/iter (+/- 182)
test tests::leap3_bench ... bench:       1,628 ns/iter (+/- 105)
test tests::leap4_bench ... bench:       2,637 ns/iter (+/- 312)

test result: ok. 0 passed; 0 failed; 0 ignored; 4 measured; 0 filtered out
```

This clearly shows that:
- binding sub expressions is zero-cost as long as they have no side effects.
- order of evaluation *does* matter
