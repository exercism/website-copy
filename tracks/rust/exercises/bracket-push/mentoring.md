# Mentoring

## Concepts

- stack or recursion

## Reasonable solutions

A reasonable solution should do the following:

## Examples

```rust
pub fn brackets_are_balanced(string: &str) -> bool {
    let complement = |c| match c {
        '[' => ']',
        '{' => '}',
        '(' => ')',
        _ => unreachable!(),
    };

    let mut expected: Vec<char> = vec![];

    for c in string.chars() {
        match c {
            '(' | '[' | '{' => expected.push(complement(c)),
            ')' | ']' | '}' => if expected.pop() != Some(c) {
                return false;
            },
            _ => {}
        }
    }

    expected.is_empty()
}
```
