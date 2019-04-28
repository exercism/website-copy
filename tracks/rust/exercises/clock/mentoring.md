### Concepts

- derive macro: [Debug](https://doc.rust-lang.org/std/fmt/trait.Debug.html) and [PartialEq](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html#derivable)
- [struct](https://doc.rust-lang.org/std/keyword.struct.html)
- [constants](https://doc.rust-lang.org/std/keyword.const.html)
- [implmentations](https://doc.rust-lang.org/std/keyword.impl.html)
- traits: [Display](https://doc.rust-lang.org/std/fmt/trait.Display.html)

### Reasonable solutions

A reasonable solution should:

* Use `#[derive]`
* Implement `fmt::Display`
* Reuse logic by implementing `Clock::add_minutes` in terms of `Clock::new`, or vice versa.
* Use `%` instead of a loop.
* Keep implementation details private.
* Have clean logic for performing the modulus.
* Have an extremely simple `fmt::Display` impl.

#### Examples

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

```
fn reduced_minutes(minutes: i32) -> i32 {
    match minutes % MINUTES_PER_DAY {
        x if x < 0 => x + MINUTES_PER_DAY,
        x => x,
    }
}
```

For a clock that stores both minutes and hours (this is generally trickier):

```rust
#![feature(euclidean_division)]
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

### Common Suggestions

If they implement Debug or PartialEq manually:

```markdown
We can use the `#[derive]` attribute on the `Clock` struct to automatically
generate impls of [Debug](https://doc.rust-lang.org/std/fmt/trait.Debug.html)
and [PartialEq](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html#derivable).
```

If they visibly lament the behavior of `%` on negative arguments:

```markdown
The standard library does provide a method called [`rem_euclid`] that produces a
non-negative result, but it is currently unstable.  We can help test it out on a
nightly version of the compiler by adding a `#![feature]` flag as shown in the
method's documentation.

[`rem_euclid`]: https://doc.rust-lang.org/std/primitive.i32.html#method.rem_euclid
```

If a helper function is `pub`:

```markdown
The `pub` modifier can be removed from this function to keep it a
private implementation detail.
```

If there are patterns like `((a % b) + b) % b` in `Clock::new` or `Clock::add_minutes`:

````markdown
This can be pulled out into a helper function to help keep the methods of `Clock` cleaner.
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

If it looks like they could benefit from learning about floored or Euclidean division (e.g. they have a helper function for the modulus but it is very specialized):

```markdown
Your `reduced_minutes` function is a nice, clean way to solve the problem,
but there is a more general concept you might find useful here.
The reason that the `%` operator in Rust can return a negative result is because
`/` in Rust is defined to round towards zero.  But there are other ways to define
integer division that produce a positive result, such as floored division/modulus
or Euclidean division/modulus.

We can try implementing one of these modulus functions, or alternatively, we can
help test out the (currently unstable) implementation of [`rem_euclid`] in the
standard library.

[`rem_euclid`]: https://doc.rust-lang.org/std/primitive.i32.html#method.rem_euclid
```

It turns out that this problem is generally trickier to solve if the clock stores both hours and minutes. If their logic is hopelessly complicated and you're not sure where else to begin:

```markdown
Here's a secret: This problem is easier to solve if the clock only stores minutes!
```
