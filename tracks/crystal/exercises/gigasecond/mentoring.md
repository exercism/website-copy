# Mentoring

### Reasonable Solutions

The time difference can be calculated using `Time#+(Time::Span)` or `Time#shift(seconds: Int)`.

```crystal
module Gigasecond
  GIGASECOND = 1_000_000_000.seconds

  def self.from(time : Time) : Time
    time + GIGASECOND
  end
end
```

### Structure

`Gigasecond` should be either a module or a `Struct`. The Crystal documentation suggests using a `Struct` for performance reasons, but this should be a talking point rather than a requirement; modules are perfectly fine. A class works as well, but is not preferable since the object will not be instantiated.

### Style

Using `Integer#seconds` to get a `Time::Span` instance is preferable to any alternatives. Using type annotation in the method signature is not required, but could be a talking point at the mentor's discretion. Crystal's source code generally omits such annotation, but annotation can be useful in larger projects, and for debugging purposes. Using either `1e9` or `1_000_000_000` is preferable to `1000000000`. Storing that value in a constant is arguably preferable.
