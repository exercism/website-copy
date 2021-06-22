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
- some students call 2 times the `windows` function instead of checking the size. From the performance point of view it's the same because the `windows` function do the check before applying the window process.

### Examples

```rust
#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(first_list: &[T], second_list: &[T]) -> Comparison {
    let is_sublist = |first: &[T], second: &[T]| {
        first.is_empty() || second.windows(first.len()).any(|window| first == window)
    };

    let f = first_list.len();
    let s = second_list.len();

    if f == s && first_list == second_list {
        Comparison::Equal
    } else if f < s && is_sublist(first_list, second_list) {
        Comparison::Sublist
    } else if f > s && is_sublist(second_list, first_list) {
        Comparison::Superlist
    } else {
        Comparison::Unequal
    }
}
```
