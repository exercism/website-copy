### Concepts

- hashmap
- macros
- macros by example (`macro_rules!`)

### Reasonable solutions

A reasonable solution should do the following:

- be hygienic (add an extra `{}` scope inside branches)
- allow for a trailing comma by using a recursive macro or a `$(,)?` block

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

Using `$(,)?` (requires Rust 2018):

```rust
#[macro_export]
macro_rules! hashmap {
    ( $($key:expr => $value:expr),* $(,)? ) => {
        {
            let mut _m = ::std::collections::HashMap::new();
            $(_m.insert($key, $value);)*
            _m
        }
    };
}
```

# References

The recursive version of this macro is implemented in the [`maplit`
crate](https://github.com/bluss/maplit/blob/master/src/lib.rs#L46-L61).
