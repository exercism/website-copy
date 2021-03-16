# Mentoring

## Concepts

- derive macro: [Debug](https://doc.rust-lang.org/std/fmt/trait.Debug.html) and [PartialEq](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html#derivable)
- [struct](https://doc.rust-lang.org/std/keyword.struct.html)
- [constants](https://doc.rust-lang.org/std/keyword.const.html)
- [implementations](https://doc.rust-lang.org/std/keyword.impl.html)
- traits: [Display](https://doc.rust-lang.org/std/fmt/trait.Display.html)

## Reasonable solutions

A reasonable solution should:

* Use `#[derive]`
* Not re-`use` the [Rust prelude](https://doc.rust-lang.org/std/prelude/index.html).
* Implement `fmt::Display`
* Reuse logic by implementing `Clock::add_minutes` in terms of `Clock::new`, or vice versa.
* Use `%` or [`rem_euclid`] instead of a loop.
* Keep implementation details private.
* Have clean logic for performing the modulus.
* Have an extremely simple `fmt::Display` impl.

### Examples

```rust
use std::fmt;

#[derive(Debug, PartialEq)]
pub struct Clock {
    minutes: i32,
}

const MINUTES_PER_DAY: i32 = 60 * 24;

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        Clock {
            minutes: rem_floor(hours * 60 + minutes, MINUTES_PER_DAY),
        }
    }

    pub fn add_minutes(self, minutes: i32) -> Self {
        Clock::new(0, self.minutes + minutes)
    }
}

impl fmt::Display for Clock {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{:02}:{:02}", self.minutes / 60, self.minutes % 60)
    }
}

fn rem_floor(x: i32, modulus: i32) -> i32 {
    ((x % modulus) + modulus) % modulus
}
```

A more specialized helper function is okay:

```rust
fn reduced_minutes(minutes: i32) -> i32 {
    match minutes % MINUTES_PER_DAY {
        x if x < 0 => x + MINUTES_PER_DAY,
        x => x,
    }
}
```

For a clock that stores both minutes and hours (this is generally trickier):

```rust
use std::fmt;

#[derive(Debug, PartialEq)]
pub struct Clock {
    hours: i32,
    minutes: i32,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        let total_minutes = hours * 60 + minutes;
        Clock {
            hours: total_minutes.div_euclid(60).rem_euclid(24),
            minutes: total_minutes.rem_euclid(60),
        }
    }

    pub fn add_minutes(self, minutes: i32) -> Self {
        Clock::new(self.hours, self.minutes + minutes)
    }
}

impl fmt::Display for Clock {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{:02}:{:02}", self.hours, self.minutes)
    }
}
```

For using the chrono crate, which was introduced in Gigasecond.

```rust
use chrono::{Duration, NaiveTime};
use std::fmt;
use std::fmt::Formatter;

#[derive(Debug, PartialEq)]
pub struct Clock {
    time: NaiveTime,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        Clock {
            time: NaiveTime::from_hms(0, 0, 0)
                + Duration::hours(hours as i64)
                + Duration::minutes(minutes as i64),
        }
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        Clock {
            time: self.time + Duration::minutes(minutes as i64),
        }
    }
}

impl fmt::Display for Clock {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        let formatted_time = &self.time.format("%H:%M").to_string();

        write!(f, "{}", formatted_time)
    }
}
```

### Common Suggestions

If they implement Debug or PartialEq manually:

```markdown
We can use the `#[derive]` attribute on the `Clock` struct to automatically
generate impls of [Debug](https://doc.rust-lang.org/std/fmt/trait.Debug.html)
and [PartialEq](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html#derivable).
```

If they `use std::cmp::PartialEq` or `std::result::Result`, which are both
included in the [Rust prelude]:

```markdown
It is good to be explicit, but the [Rust prelude] already brings common modules
into scope so that you do not have to `use` them again.

[Rust prelude]: https://doc.rust-lang.org/std/prelude/index.html
```

If they implement `to_string` manually:

```markdown
We can implement the [`Display`] trait for `Clock`, which contains an implementation
of `to_string`. 

[`Display`]: https://doc.rust-lang.org/std/fmt/trait.Display.html
```

Using % and / is fine, but if they seem to visibly struggle with them in the code, [`rem_euclid`] and [`div_euclid`] can help:

```markdown
Instead of % or /, you can use the integer method [`rem_euclid`] which returns
non-negative results, or [`div_euclid`] for Euclidean division. These were
made stable in Rust 1.38.

[`rem_euclid`]: https://doc.rust-lang.org/std/primitive.i32.html#method.rem_euclid
[`div_euclid`]: https://doc.rust-lang.org/std/primitive.i32.html#method.div_euclid
```

If a helper function is `pub`:

```markdown
The `pub` modifier can be removed from this function to keep it a
private implementation detail.
```

If there are patterns like `((a % b) + b) % b` in `Clock::new` or `Clock::add_minutes`:

````markdown
This code can be pulled out into a helper function to help keep the methods of
`Clock` cleaner.
For example:

```rust
/// Like `a % b`, but positive for positive `a`.
fn rem_floor(x: i32, modulus: i32) -> i32 {
    // ...
}
```
````

If they already have a modulus function factored out from the get-go:

```markdown
Let's take this a step further and add a unit test for your `rem_floor` function!

Notice you are allowed to put `#[test]` functions alongside the rest of your
code (i.e. in `src/lib.rs`), where they can see and test private functions.
```

It turns out that this problem is generally trickier to solve if the clock stores both hours and minutes. If their logic is hopelessly complicated and you're not sure where else to begin:

```markdown
Here's a secret: This problem is easier to solve if the clock only stores minutes!
```

If they didn't use the chrono crate

```markdown
Another approach to consider would be to use [`chrono::NaiveTime`] with [`chrono::Duration`]. The `chrono` crate was introduced in the Gigasecond exercise.

[`chrono::NaiveTime`]: https://docs.rs/chrono/0.4.19/chrono/naive/struct.NaiveTime.html
[`chrono::Duration`]: https://docs.rs/chrono/0.4.19/chrono/struct.Duration.html
```
