# Space Age

## Concepts

- custom trait
- default trait implementation

## Reasonable solutions

A reasonable solution should do the following:

### Examples

```rust
pub struct Duration {
    seconds: u64,
}

impl From<u64> for Duration {
    fn from(s: u64) -> Self {
        Duration { seconds: s }
    }
}

pub trait Planet {
    const YEAR_LENGTH: f64;

    fn years_during(d: &Duration) -> f64 {
        let age_on_earth = |dur: &Duration| dur.seconds as f64 / 31_557_600.0;
        age_on_earth(d) / Self::YEAR_LENGTH
    }
}

pub struct Mercury;
pub struct Venus;
pub struct Earth;
pub struct Mars;
pub struct Jupiter;
pub struct Saturn;
pub struct Uranus;
pub struct Neptune;

impl Planet for Mercury {
    const YEAR_LENGTH: f64 = 0.240_846_7;
}

impl Planet for Venus {
    const YEAR_LENGTH: f64 = 0.615_197_26;
}

impl Planet for Earth {
    const YEAR_LENGTH: f64 = 1.0;
}

impl Planet for Mars {
    const YEAR_LENGTH: f64 = 1.880_815_8;
}

impl Planet for Jupiter {
    const YEAR_LENGTH: f64 = 11.862_615;
}

impl Planet for Saturn {
    const YEAR_LENGTH: f64 = 29.447_498;
}

impl Planet for Uranus {
    const YEAR_LENGTH: f64 = 84.016_846;
}

impl Planet for Neptune {
    const YEAR_LENGTH: f64 = 164.791_32;
}
```

## Example Comments
