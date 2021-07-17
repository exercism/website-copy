# Mentoring

## Concepts

- enum
- generic over type

## Reasonable solutions

A reasonable solution should do the following:

- solve the subproblem of checking if a list is a sublist of another list
- utilize Eq for slices
- not reimplement the functionality of the `windows` method
- optionally use pattern matching instead of `if/else`

## Examples

```rust
#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(first_list: &[T], second_list: &[T]) -> Comparison {
    if first_list == second_list {
        Comparison::Equal
    } else if contains(first_list, second_list) {
        Comparison::Sublist
    } else if contains(second_list, first_list) {
        Comparison::Superlist
    } else {
        Comparison::Unequal
    }
}

fn contains<T: PartialEq>(sublist: &[T], list: &[T]) -> bool {
    sublist.is_empty() || list.windows(sublist.len()).any(|window| window == sublist)
}
```

Using `match`

```rust
#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(first: &[T], second: &[T]) -> Comparison {
    let is_sublist = contains(first, second);
    let is_superlist = contains(second, first);

    match (is_sublist, is_superlist) {
        (true, true) => Comparison::Equal,
        (true, _) => Comparison::Sublist,
        (_, true) => Comparison::Superlist,
        _ => Comparison::Unequal,
    }
}

fn contains<T: PartialEq>(sublist: &[T], list: &[T]) -> bool {
    sublist.is_empty() || list.windows(sublist.len()).any(|window| window == sublist)
}
```
