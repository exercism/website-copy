# Mentoring

## Concepts

- Option
- Math

## Reasonable solutions

A reasonable solution should do the following:

- Use `a.pow(2)` rather than `a*a`
- not use return for the last line of the function
- Not use floating point values, which introduce the posibility of rounding errors
- Not introduce posibility of integer underflow.

A good solution may go above and beyond and also do the following:

- Solve the problem with Euler's formula
- Break out the core logic of find into a variant that takes the perimeter as an argument
- Introduce negative test cases.

## Examples

restricting iteration to only be over valid triangles

```rust
use std::cmp::max;
use std::collections::HashSet;

pub fn find(sum: u32) -> HashSet<[u32; 3]> {
    let mut results = HashSet::new();

    for a in 2..(sum / 3) {
        let bmin = sum / 2 - a + 1;
        let cmax = sum - bmin - a;
        let diff = cmax - bmin;

        for b in max(bmin, a)..=bmin + (diff / 2) {
            let c = sum - b - a;
            if a * a + b * b == c * c {
                results.insert([a, b, c]);
            }
        }
    }

    results
}
```

## Example Comments

If they dont use `pow`

```
You could have used `num.pow(2)` rather than `num*num`.
```

If they only have minor issues but they're not related to the core concepts of
the exercise.

```
These are relatively minor though, you nailed the usage of Option which is the
language feature this exercise is meant to teach. Great work :)
```
