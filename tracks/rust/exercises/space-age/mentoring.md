# Mentoring

### Concepts

- custom trait
- default trait implementation

### Reasonable solutions

A reasonable solution should do the following:

- Use an associated constant on the Planet trait
- Use a default trait implementation for years_during
- Bonus points if they use a macro to clean up the constant definition

### Examples

```rust
const EARTH_YEAR_IN_SECONDS: f64 = 31557600.0;

#[derive(Debug)]
pub struct Duration(f64);

impl From<u64> for Duration {
    fn from(s: u64) -> Self {
        Duration(s as f64)
    }
}

pub trait Planet {
    const YEAR_IN_SECONDS: f64;

    fn years_during(d: &Duration) -> f64 {
        d.0 / Self::YEAR_IN_SECONDS
    }
}

macro_rules! define_planet {
    (name = $name:ident, orbit = $orbit:expr) => {
        pub struct $name;

        impl Planet for $name {
            const YEAR_IN_SECONDS: f64 = EARTH_YEAR_IN_SECONDS * $orbit;
        }
    };
}

define_planet!(name = Mercury, orbit = 0.2408467);
define_planet!(name = Venus, orbit = 0.61519726);
define_planet!(name = Earth, orbit = 1.0);
define_planet!(name = Mars, orbit = 1.8808158);
define_planet!(name = Jupiter, orbit = 11.862615);
define_planet!(name = Saturn, orbit = 29.447498);
define_planet!(name = Uranus, orbit = 84.016846);
define_planet!(name = Neptune, orbit = 164.79132);
```

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

### Common Suggestions

Upon passing the tests, the student may appreciate being introduced to macros with this exercise.

```markdown
Another approach to consider is how the use of a macro could reduce the boilerplate for this exercise. For instance, [`a macro can implement a trait for multiple types at once`], though it is fine to implement `years_during` in the Planet trait itself. In the community solutions you may see a macro defining both the structs and their implementations.

Info to get started with macros can be found [`here`] and [`here`].


[`a macro can implement a trait for multiple types at once`]: https://stackoverflow.com/questions/39150216/implementing-a-trait-for-multiple-types-at-once
[`here`]: https://doc.rust-lang.org/rust-by-example/macros/syntax.html
[`here`]: https://doc.rust-lang.org/1.7.0/book/macros.html

```
