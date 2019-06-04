### Reasonable solutions

A reasonable solution should:

* Use `.any()` or `.all()` to check for yelling and for alphabetic characters.
* Does not allocate any extra strings.
* Uses a `match` block or `if`-statements to decide which value to return.

#### Examples

```rust
pub fn reply(message: &str) -> &str {
    match (is_question(message), is_yell(message), is_blank(message)) {
        (true, true, _) => "Calm down, I know what I'm doing!",
        (true, _, _) => "Sure.",
        (_, true, _) => "Whoa, chill out!",
        (_, _, true) => "Fine. Be that way!",
        _ => "Whatever.",
    }
}

fn is_blank(message: &str) -> bool {
    message.trim().is_empty()
}

fn is_question(message: &str) -> bool {
    message.trim().ends_with('?')
}

fn is_yell(message: &str) -> bool {
    has_letters(message) && !message.chars().any(char::is_lowercase)
}

fn has_letters(message: &str) -> bool {
    message.chars().any(char::is_alphabetic)
}
```
