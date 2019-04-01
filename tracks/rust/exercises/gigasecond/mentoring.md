### Concepts

- Integer
- constant
- struct (We're returning the `Utc` struct, which is the field in the
`DateTime` struct from the Chrono crate)

### Reasonable solutions

A reasonable solution should:

- Use constants
- Use underscores in place of commas
- Be explicit with use lines
- Not use `return`
- Not use methods like `.add()` or `.checked_add_signed()`
- Not use variables
- Not use `.unwrap()` or `.expect()`
- Not use `.pow()`

### Examples

```rust
use chrono::{DateTime, Duration, Utc};

const GIGASECOND: i64 = 1_000_000_000;

pub fn after(start: DateTime<Utc>) -> DateTime<Utc> {
    start + Duration::seconds(GIGASECOND)
}
```

### Example Comments

If they don't use a constant:
```
We can improve this by storing the number we input to `seconds()` as a constant.
```

If they don't use underscores:
```
The standard Rust syntax is to use underscores in place of commas to make your code more readable. So, `1000000000` becomes `1_000_000_000`.
```

If they aren't explicit with their use lines:
```
Wildcards are actually unideal. We really want to be explicit with our `use` lines, so we know exactly what we are utilising :)
```

If they use `return`:
```
We don't need to use the `return` keyword here, we only use that for early returns.
```

If they use other methods:
```
We don't need to use the `.add()` call here, we can simply do `start +`.
```

If they use a variables:
```
We don't need to create a variable here. We can combine `start +` and the `Duration` call and just directly return that all in one line.
```

If they use `.unwrap()` or `.expect()`:
```
We want to avoid `.unwrap()`. If we can't avoid it, at the very least, use `.expect()`, so we can output a helpful error message.
```

If they use `.pow()`:
```
We don't need to use `.pow()`.
```