# Mentoring

## Concepts

- [&str](https://doc.rust-lang.org/std/primitive.str.html)
- [String](https://doc.rust-lang.org/std/string/struct.String.html)
- [Iterators](https://doc.rust-lang.org/std/iter/trait.Iterator.html)
- [Iterator Methods](https://doc.rust-lang.org/std/iter/trait.Iterator.html#provided-methods)

## Reasonable solutions

A reasonable solution should:

- Use [.chars()](https://doc.rust-lang.org/std/primitive.str.html#method.chars),
[.rev()](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.rev), and
[.collect()](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.collect)
- No need to be explicit with `.collect()` by using the turbofish operator `::<>` because the collected type is in the type signature.
- Not use other iterators or iterator methods like `.into_iter()` or
`.flat_map()`
- Not use variables or loops
- Not use `return`

A bonus solution should:

- Use the [unicode_segmentation crate](https://unicode-rs.github.io/unicode-segmentation/unicode_segmentation/index.html)
- Use `input.graphemes(true)` instead of
`UnicodeSegmentation::graphemes(input, true)`.
The documentation for this method can be found [here](https://unicode-rs.github.io/unicode-segmentation/unicode_segmentation/trait.UnicodeSegmentation.html#tymethod.graphemes).

### Examples

```rust
pub fn reverse(input: &str) -> String {
    input.chars().rev().collect()
}
```

### Bonus solution

```rust
use unicode_segmentation::UnicodeSegmentation;

pub fn reverse(input: &str) -> String {
    input.graphemes(true).rev().collect()
}
```

### Common Suggestions

If they use other iterators:
```
We don't need the `.into_inter()` call since `.chars()` returns an iterator.
```

If they use other iterator methods:
```
We don't need the `.flat_map()` call.
```

If they don't use `.rev()`:
```
There's a method in the standard library that reverses the direction of an iterator, in this case, produced by `.chars()`.
```

If they use variable(s):
```
We can `.collect()` directly into a `String` without storing the data in a variable.
```

If they use a mutable variable and loop:
```
I'm glad you figured out a solution!

The methodology of creating a mutable variable and modifying it from a loop is an antiquated way of thinking, though.

We can do this in a more Rust-like/idiomatic and concise manner by just using iterators and chained method calls :)

Check out the [.collect()](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.collect) method. This will allow us to omit the loop.
```

If they use a `return`:
```
We don't need to use the `return` keyword here, we only use that for early returns.
```

If they haven't done the bonus:

```
Do you want to give the bonus a go? :)
```

### Common Suggestions For The Bonus

If they ask, "What bonus?"
```
In `README.md`, it talks about "grapheme clusters". If you look in the test suite, you'll see the last test, `test_grapheme_clusters()`, which has unicode characters (they're not all ASCII).

You can run all of the tests with this command: `cargo test --features grapheme -- --ignored`.
```

If they are struggling:
```
As for the graphemes bonus, have a look at the [unicode_segmentation crate](https://crates.io/crates/unicode-segmentation).
```

If they use `UnicodeSegmentation::graphemes(input, true)` instead of `input.graphemes(true)`:

```
Since `.graphemes()` takes a reference to `self` (`&self`), that means we can call it without putting a variable between the parentheses. This allows our program flow to read like a sentence.
```
