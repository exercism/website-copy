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
    ( $($key:expr => $value:expr,)+ ) => { hashmap!($($key => $value),+) }
}
```

### Common Suggestions

- One way to handle trailing commas in the macro expansion in lieu of the recursive call is to do something like this
```rust
( $($key:expr => $value:expr),* $(,)? ) => { ... }
```
where `$(,)?` specifies that there can be 0 or 1 trailing commas after the expressions specifying key-value pairs. Doing the above allows for something like `hashmap!(,)` to successfully compile. However, if we're going for parity with the `vec![]` macro, `hashmap!(,)` shouldn't compile since `vec![,]` doesn't compile. So if a student uses the `$(,)?` expression to handle trailing commas, steer them towards the recursive approach.