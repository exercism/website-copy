# Mentoring

## Concepts

- ascii
- chars
- iterators
- primitive types

## Reasonable solutions

A reasonable solution should do the following:

- Use byte literals rather than integer literals to represent ascii characters.
  Use `b'a'` rather than `97`.
- Use char methods for working with ascii data, all of which contain `_ascii_`
  in their name, rather than filtering characters with `is_ascii` and using
  unicode centric methods for manipulation.
- Factor the common logic into a separate function rather than duplicating
  filtering and transposition in encode and decode. **Bonus** its fine if this
  function returns a String or if they just use decode as the starting point of
  encode, but this is good place to introduce the `impl Trait` in the return
  position after having already approved the exercise.
- **Optional**: Avoid heap allocations when inserting spaces into the encoded
  final string. Its better to `flat_map` spaces into the iterator than
  collecting each set of chunks and joining the slices together with spaces.
  Using itertools `chunks` and `join` is okay but can cause lifetime issues
  that are fixed with NLL, its okay for students so use this but if they do its
  a good idea to show them alternative solutions that use only std methods.

## Examples

```rust
use std::iter::once;

static ALPHABET: &'static str = "abcdefghijklmnopqrstuvwxyz";

/// "Encipher" with the Atbash cipher.
pub fn encode(plain: &str) -> String {
    atbash(plain)
        .enumerate()
        .flat_map(|(ind, c)| {
            match ind % 5 {
                0 if ind > 0 => Some(' '),
                _ => None,
            }.into_iter()
            .chain(once(c))
        }).collect()
}

/// "Decipher" with the Atbash cipher.
pub fn decode(cipher: &str) -> String {
    atbash(cipher).collect()
}

fn trans(c: char) -> char {
    ALPHABET.find(c).map_or(c, |ind| {
        ALPHABET.chars().nth(ALPHABET.len() - 1 - ind).unwrap()
    })
}

fn atbash<'a>(s: &'a str) -> impl Iterator<Item = char> + 'a {
    s.chars().filter_map(|c| {
        Some(c)
            .filter(|c| c.is_ascii_alphanumeric())
            .map(|c| c.to_ascii_lowercase())
            .map(trans)
    })
}
```

```rust
use std::iter;

/// "Encipher" with the Atbash cipher.
pub fn encode(plain: &str) -> String {
    transpose(plain)
        .enumerate()
        .flat_map(|(i, c)| {
            Some(' ')
                .filter(|_| i % 5 == 0)
                .into_iter()
                .chain(iter::once(c))
        })
        .skip(1)
        .collect()
}

/// "Decipher" with the Atbash cipher.
pub fn decode(cipher: &str) -> String {
    transpose(cipher).collect()
}

fn transpose<'a>(text: &'a str) -> impl Iterator<Item = char> + 'a {
    text.chars()
        .filter(char::is_ascii_alphanumeric)
        .map(|c| c.to_ascii_lowercase())
        .map(|c| {
            if c.is_ascii_alphabetic() {
                (b'z' - (c as u8 - b'a')) as char
            } else {
                c
            }
        })
}
```

```rust
use std::char;
use std::iter;

fn make_iter<'a>(text: &'a str) -> impl Iterator<Item = char> + 'a {
    text.chars().filter_map(|s| match s {
        '0'...'9' => Some(s),
        'a'...'z' | 'A'...'Z' => s
            .to_digit(36)
            .and_then(|num| char::from_digit(35 - num + 10, 36)),
        _ => None,
    })
}

/// "Encipher" with the Atbash cipher.
pub fn encode(plain: &str) -> String {
    make_iter(plain)
        .enumerate()
        .flat_map(|(i, x)| {
            iter::once(' ')
                .filter(move |_y| i % 5 == 0 && i != 0)
                .chain(iter::once(x))
        }).collect()
}

/// "Decipher" with the Atbash cipher.
pub fn decode(cipher: &str) -> String {
    make_iter(cipher).collect()
}
```

```rust
mod separate {
    use itertools::Itertools;
    use std::iter::FromIterator;

    pub trait Separate<'a, I, T, O>
    where
        I: IntoIterator<Item = T>,
        T: Copy,
        O: FromIterator<T>,
    {
        /// Separate a stream into groups, inserting a copy of T between each.
        /// Then collect it.
        ///
        /// This is a fused iterator.
        //
        // While it would be nice not to need to collect the output, just return
        // `impl Iterator<Item=T>` instead of `O`, the lifetimes of the chunk
        // iterators make that impossible.
        fn separate(self, group_sep: T, group_size: usize) -> O;
    }

    // Strictly speaking, this is not a single-allocation operation: we create
    // two boxed trait objects. However, rustc should be smart enough to ensure
    // that those boxes are reused; in the end, this allocates two constant-size
    // box pointers, plus the output object.
    impl<'a, I, T, O> Separate<'a, I, T, O> for I
    where
        I: 'a + IntoIterator<Item = T>,
        <I as IntoIterator>::IntoIter: 'a,
        T: 'a + Copy + PartialEq,
        O: FromIterator<T>,
    {
        fn separate(self, group_sep: T, group_size: usize) -> O {
            self.into_iter()
                .fuse()
                .chunks(group_size)
                .into_iter()
                .map(|chunk| {
                    let d: Box<dyn Iterator<Item = T>> = Box::new(chunk);
                    d
                })
                .interleave_shortest(std::iter::repeat(std::iter::once(group_sep)).map(|cyc| {
                    let d: Box<dyn Iterator<Item = T>> = Box::new(cyc);
                    d
                }))
                .flatten()
                .with_position()
                .filter_map(move |pos| {
                    use itertools::Position::*;
                    match pos {
                        Only(c) => Some(c),
                        First(c) => Some(c),
                        Middle(c) => Some(c),
                        Last(c) if c != group_sep => Some(c),
                        _ => None,
                    }
                })
                .collect()
        }
    }
}

use separate::Separate;

fn transpose(c: char) -> Option<char> {
    if !c.is_ascii_alphanumeric() {
        return None;
    }
    Some(if c.is_ascii_alphabetic() {
        let c = c.to_ascii_lowercase() as u8;
        (b'z' - (c - b'a')) as char
    } else {
        c
    })
}

/// "Encipher" with the Atbash cipher.
pub fn encode(plain: &str) -> String {
    plain.chars().flat_map(transpose).separate(' ', 5)
}

/// "Decipher" with the Atbash cipher.
pub fn decode(cipher: &str) -> String {
    cipher.chars().flat_map(transpose).collect()
}
```

## Example Comments

If they're not using ascii specific char functions.

```
First thing I notice is that you're using Unicode centric methods for `str` and
`char`. These methods add extra runtime overhead by creating heap allocated
strings and are unnecessary because you're only expected to work with ASCII
data, filtering out any non-ASCII data.

Check out the other methods available for `char`s that are meant to work with
ASCII input and see how you can use those to clean up the transformation step.
```

If they duplicate shared logic of encode and decode.

```
This is a good start, however there's quite a bit of code duplication.

It helps if you try to come at the atbash cipher as an almost symmetrical
transformation, the only difference being that encode has an extra step to
insert spaces.

Try rewriting the core logic as a common function. Bonus points if you write
this to return an iterator.
```
