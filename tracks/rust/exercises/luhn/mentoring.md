# Mentoring

## Concepts

- higher-order functions
- iterators
- str to digits

## Reasonable solutions

A reasonable solution should do the following:

- use iterators rather than loops.
- utilize higher order functions on iterators and on option types

## Examples

```rust
pub fn is_valid(code: &str) -> bool {
    code.chars()
        .rev()
        .filter(|c| !c.is_whitespace())
        .try_fold((0, 0), |(sum, c), d| {
            d.to_digit(10)
                .map(|n| if c % 2 == 1 { n * 2 } else { n })
                .map(|n| if n > 9 { n - 9 } else { n })
                .map(|n| (n + sum, c + 1))
        }).map_or(false, |(sum, count)| sum % 10 == 0 && count > 1)
}
```
