### Concepts

- derive
- struct
- traits

### Reasonable solutions

A reasonable solution should do the following:

* Use `#[derive]`
* Implement `fmt::Display`
* Reuse logic by implementing `Clock::add_minutes` in terms of `Clock::new`, or vice versa.
* Prefer `24 * 60` over the rather magical `1440`.
* Use `%` instead of a loop.
* Have clean logic for performing the modulus.
* (more items needed here)

### Examples

```rust
#![feature(euclidean_division)]
use std::fmt;

#[derive(Debug, PartialEq)]
pub struct Clock {
    minutes: i32,
}

const MINS_PER_DAY: i32 = 60 * 24;

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        Clock {
            minutes: (hours * 60 + minutes).mod_euc(MINS_PER_DAY),
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
```

### Notes

If somebody visibly laments the behavior of `%` on negative arguments, you can tell them how to use unstable features like `rem_euclid`.

"Clean logic" for the modulus ideally means that there is usage of a function that returns a positive modulus.  (basically an implementation of `rem_floor`, or usage of the unstable `rem_euclid`).  Notice that, if the clock stores hours in addition to minutes, the corresponding `div_floor` or `div_euclid` are also necessary.

If somebody already has such functions in their code, you can ask them to take it a step above and add a test for it.  (this is a good opportunity to show that tests can be in `src/lib.rs` where they can see private functions, rather than always having to be in `tests/`)

It is fine if the clock stores both hours and minutes, but if somebody's logic is hopelessly complicated, suggest that it might be easier to only store `minutes`.
