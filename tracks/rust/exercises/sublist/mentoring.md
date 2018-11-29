### Concepts

- enum
- generic over type

### Reasonable solutions

A reasonable solution should do the following:

- break down the unordered size problem into two subproblems, checking if a
  list is smaller than another, and checking if a smaller list is a sublist of
  a larger list
- Utilize Eq for slices
- not reimplement the functionality of the `windows` method

### Examples

```rust
#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(_first_list: &[T], _second_list: &[T]) -> Comparison {
    let is_sublist = |first: &[T], second: &[T]| {
        first.is_empty() || second.windows(first.len()).any(|window| first == window)
    };

    let f = _first_list.len();
    let s = _second_list.len();

    if f == s && _first_list == _second_list {
        Comparison::Equal
    } else if f < s && is_sublist(_first_list, _second_list) {
        Comparison::Sublist
    } else if f > s && is_sublist(_second_list, _first_list) {
        Comparison::Superlist
    } else {
        Comparison::Unequal
    }
}
```
