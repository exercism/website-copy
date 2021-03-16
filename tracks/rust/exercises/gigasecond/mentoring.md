# Mentoring

### Concepts

- [Integer (i64 in this case)](https://doc.rust-lang.org/std/primitive.i64.html)
- [constant](https://doc.rust-lang.org/std/keyword.const.html)
- [struct](https://doc.rust-lang.org/std/keyword.struct.html)
(We're returning the [Utc](https://docs.rs/chrono/0.4.6/chrono/offset/struct.Utc.html) struct,
which is the `offset` field in the [DateTime](https://docs.rs/chrono/0.4.6/chrono/struct.DateTime.html)
struct from the [Chrono crate](https://docs.rs/chrono))

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

#### Examples

```rust
use chrono::{DateTime, Duration, Utc};

const GIGASECOND: i64 = 1_000_000_000;

pub fn after(start: DateTime<Utc>) -> DateTime<Utc> {
    start + Duration::seconds(GIGASECOND)
}
```

### Common Suggestions

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

If the `use` elements are out of alphabetical order the student may appreciate being introduced to `rustfmt`.
```rust
use chrono::{DateTime, Utc, Duration};
```
```markdown
A minor style point is that `rustfmt`  will usually put `use` elements in alphabetical order. In larger programs with a lot of `use` statements it can be helpful to have them ordered alphabetically.
```

Whether they use a `const` or not, the student may appreciate being introduced to cargo-asm.
```markdown
Some coders may prefer to create a `const` with the gigasecond value and use that in `after`. I could see doing that if the value were used in multiple places, but since it's only used in one place in this short program I don't think it's really needed, though it's fine to do so. I'm told by several people that [`cargo-asm`] shows that either way compiles into the same assembly instructions.

[`cargo-asm`]: https://crates.io/crates/cargo-asm
```
