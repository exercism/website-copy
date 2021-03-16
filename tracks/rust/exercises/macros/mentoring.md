# Mentoring

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

A more concise alternate solution.
```rust
#[macro_export]
macro_rules! hashmap {
    ($($( $key: expr => $val: expr )+$(,)?)*) => {{
         let mut map = ::std::collections::HashMap::new();
         $($( map.insert($key, $val); )*)*
         map
    }}
}
```
```markdown
The inside pattern is saying to match one or more of key=>val with zero or one comma after it. The outside pattern is saying there could be zero or more of the inside pattern, which takes care of `test_empty`.
```
