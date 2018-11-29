# Macros

## Concepts

- hashmap
- macros
- macros by example

## Reasonable solutions

A reasonable solution should do the following:

### Examples

```rust
#[macro_export]
macro_rules! hashmap {
    ( $($key:expr => $value:expr),* ) => {
        {
            let mut _m = ::std::collections::HashMap::new();
            $(_m.insert($key, $value);)*
            _m
        }
    };
    ( $($key:expr => $value:expr,)+ ) => { hashmap!($($key => $value),+) }
}
```

## Example Comments
