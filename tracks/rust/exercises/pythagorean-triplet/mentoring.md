### Concepts

- Option
- Math

### Reasonable solutions

A reasonable solution should do the following:

- Use `a.pow(2)` rather than `a*a`
- not use return for the last line of the function
- Not use floating point values, which introduce the posibility of rounding errors
- Not introduce posibility of integer underflow.
- Accounts for possibly not finding a triplet and returns None, not Some(0)

A good solution may go above and beyond and also do the following:

- Solve the problem with Euler's formula
- Break out the core logic of find into a variant that takes the perimeter as an argument
- Introduce negative test cases.

### Examples

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

### Example Comments

If they use return on the last line for the None variant.

```
The `return` in the last line of the function isn't necessary. In rust, blocks
evaluate to the value of the last expression in the block, so it's idiomatic to
have end-of-function return values be the value of the expression, in this
case, `None` rather than explicitly passing this value with the return keyword.
It helps to think of the return keyword as being for early returns only, like
with the `Some` variant in this problem.
```

If they dont use `pow`

```
You could have used `num.pow(2)` rather than `num*num`.
```

If they return `Some(0)`

```
All of the logic is correct but you're not quite using Option correctly.
`Option` is an enum with two variants, `Some<T>` and `None`. It is intended to
be used for return types where there may not be any sensible return value
possible. In this case, returning `Some(0)` when you fail to find a value is
incorrect, there is no valid Pythagorean triplet with a perimeter of 1000 and a
product of sides equal to 0, which is what this would imply, the correct return
value would be `None`.
```

If they only have minor issues but they're not related to the core concepts of
the exercise.

```
These are relatively minor though, you nailed the usage of Option which is the
language feature this exercise is meant to teach. Great work :)
```
