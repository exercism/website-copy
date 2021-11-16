### Concepts

- hashmap
- macros
- macros by example

### Reasonable solutions

A reasonable solution should do the following:

- utilize a recursive macro

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
    ( $($key:expr => $value:expr,)+ ) => { $crate::hashmap!($($key => $value),+) }
}
```
