# Mentoring

## Concepts

- [bool](https://doc.rust-lang.org/std/primitive.bool.html)
- [char](https://doc.rust-lang.org/std/char/index.html)
- [match statement](https://doc.rust-lang.org/1.2.0/book/match.html)
- [variables](https://doc.rust-lang.org/book/ch03-01-variables-and-mutability.html)
- [closures](https://doc.rust-lang.org/book/ch13-01-closures.html)
- [&str](https://doc.rust-lang.org/std/primitive.str.html)
- [Iterators](https://doc.rust-lang.org/std/iter/trait.Iterator.html)
- [Iterator Methods](https://doc.rust-lang.org/std/iter/trait.Iterator.html#provided-methods)
- [constant](https://doc.rust-lang.org/std/keyword.const.html)

## Reasonable Solutions

A reasonable solution should:

- Use constants
- Use variables
- Use a `match` statement
- Check if the input string is empty and return the "FINE" constant
before doing any additional processing
- Use simple methods from the standard library
- Not use the regex crate

### Examples

```rust
const SURE: &str = "Sure.";
const WHOA: &str = "Whoa, chill out!";
const CALM: &str = "Calm down, I know what I'm doing!";
const FINE: &str = "Fine. Be that way!";
const WHATEVER: &str = "Whatever.";

pub fn reply(message: &str) -> &str {
    let message = message.trim();

    if message.is_empty() {
        FINE
    } else {
        let is_question = message.ends_with('?');

        // A message is uppercase if it doesn't contain lowercase.
        // `.all(char::is_uppercase)` doesn't work because of whitespace/punctuation
        let is_yelled = message.chars().any(char::is_alphabetic) &&
            !message.chars().any(char::is_lowercase);

        match (is_question, is_yelled) {
            (true, false) => SURE,
            (false, true) => WHOA,
            (true, true) => CALM,
            (false, false) => WHATEVER,
        }
    }
}
```

Note that `message.chars().any(..)` is equivalent to `message.contains(..)`.

### Common Suggestions

If they don't use a constant:
```
We can improve this by setting our output strings to be [constants](https://doc.rust-lang.org/std/keyword.const.html)
```

If they don't create a trimmed variable or use something other than `.trim()` or `.trim_end()`:
```
Have a look at the `.trim()` method.
```

If they check if the string is empty in any other way than `.is_empty()`:
```
Well done you for seeing that we need to check if the string is empty with `== ""`. There's actually a method, `.is_empty()`, that we can use instead, which is much cleaner.
```

If they use `if` statements, you can alternatively suggest that they try out using `match`:
```
Check out using `match` instead of `if`. For some things, like destructuring, it's required. It's an idiom specific to Rust, so I always default to it unless the logic is comparing many different things and a match in that case makes it messy.
```

If they are struggling with how to check if it's a question or use something like `chars().last()`:
```
Have a look at [`.ends_with()`](https://doc.rust-lang.org/std/string/struct.String.html#method.ends_with) to check if it's a question, it's much cleaner.
```

If they use regex:
```
This is good! Great idea using the regex crate! Let's look at how to do this with just the standard library.
```
Then note the following:
```
See about finding a way to check if it's alphabetic without using regex.
```

If they don't use a `match` to compare the conditions:
````md
We can `match` on just two conditions: `is_question` and `is_yelling`. Like this:
```rust
match (is_question, is_yelling) {
    (true, false) => SURE,
    ...
```
````

If they put their constants inside the function:
```
Note that it's common convention to put constants at the beginning of a file like I've done above. If it's a public constant, which is typical, we put it following our `use` lines, along with `struct`s and `enum`s. If it's a private constant, we put it at the beginning of the scope of the function. But, either way doesn't affect the performance or functionality!
```

If they ask about `&str` having a static lifetime:
```
Lifetimes prevent dangling pointers; they are needed when a value points to some data, so the value doesn't outlive its data.

String literals are [slices](https://doc.rust-lang.org/std/primitive.slice.html) that point to a section in the executable, where all string slices are stored. Because this data is never freed, string slices are alive for the entire duration of the application, which is denoted with the special `'static` lifetime.

There's an example in [Rust By Example](https://doc.rust-lang.org/rust-by-example/scope/lifetime/static_lifetime.html).
```

If they use `_` instead of `false` in their match statement:
```
Using the `_` in the true/false `match` suggests that there's something else to catch while there isn't. This makes it less readable and can even be a source of bugs in some cases. So, we should limit its use to only when it's needed. Here, we should use `false` because there is no other option.
```
