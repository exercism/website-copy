# Mentoring

## Reasonable solution

There are two general approaches:

1. a mutable approach
2. an immutable approach

Both are valid and it makes for a nice discussion why you would or wouldn't
want to model it as one or the other. Regardless of the approach taken, there
are also different approaches to handle "roll-over", string formatting and
dealing with the equality constraint.

### The state

The internal clock state can either be modelled as a single value, converting
the input `hours` to `minutes` or the input `minutes` to fractional `hours`, or
as two separate values. This makes for a good talking point; it is often easier
to deal with one value instead of two, and delay splitting them out until the
clock should be formatted (`.toString()`).

### Normalisation

Because the clock must handle roll over in both directions, the state(s) need
to be normalised before its formattable, or can be tested for equality. The
natural approach is to take the maximum value on the clock (either minutes or
hours) and use that as wrap-around limit.

```javascript
const MINUTES_PER_CLOCK = MINUTES_PER_HOUR * HOURS_ON_THE_CLOCK

function normalize(minutes) {
  while (minutes < 0) {
    minutes += MINUTES_PER_CLOCK
  }

  return minutes % MINUTES_PER_CLOCK
}
```

The above ignores the fact that `%` in JavaScript is _not_ modulo but
_remainder_, which deals differently with negative values. The alternative is
to take the remainder twice:

```javascript
const HOURS_ON_THE_CLOCK = 24

normalize(hours) {
  return ((hour % HOURS_ON_THE_CLOCK) + HOURS_ON_THE_CLOCK) % HOURS_ON_THE_CLOCK;
}
```

If the first remainder results in a negative number, adding the "wrap-around"
`number` ensures that the next remainder will be positive.

Both approaches are valid and idiomatic.

### Clock formatting

If the state is kept in two values, at time of formatting these values are
correct. If the state is kept in one value, at time of formatting, the hours
and minutes components need to be separated out.

The idiomatic approach is to use `Math.floor` or `Math.trunc` on a division and
using `%` on the same value, effectively simulating a `divmod`, given that the
state's value is a positive number.

In older version of JavaScript, there was no `padStart` function, but since its
inclusion, solutions using `.slice` or similar, are no longer idiomatic. Always
suggest `.padStart(2, '0')`:

```javascript
function clockPad(number) {
  return String(number).padStart(2, '0')
}
```

### Equality and sameness

Since the description has a definition for sameness, one of the approaches is
to implement `valueOf`, which would reduce the clock to the number of minutes
it represents and checking the equality of those primitive values. Another
approach is to compare the internal value(s) directly.

Finally, in this particular case, one may also compare the `string` (
`.toString()`) representations of two clocks, as in this particular case, it
states that two clocks are equal if they have the same time, which can be
represented by the `.toString()` value.

### Example

Given the `clockPad` and `normalize` "minutes" function from above, here is an
idiomatic example of approaching this problem using immutability.

```javascript
const MINUTES_PER_HOUR = 60
const HOURS_ON_THE_CLOCK = 24

export class Clock {
  constructor(hours, minutes = 0) {
    this.minutes = normalize(hours * MINUTES_PER_HOUR + minutes)
  }

  toString() {
    const hours = Math.floor(this.minutes / MINUTES_PER_HOUR)
    const minutes = this.minutes % MINUTES_PER_HOUR

    return `${clockPad(hours)}:${clockPad(minutes)}`
  }

  plus(minutes) {
    return new Clock(0, this.minutes + minutes)
  }

  minus(minutes) {
    return this.plus(-minutes)
  }

  valueOf() {
    return this.minutes
  }

  equals(other) {
    return +other === +this
  }
}
```

### Common suggestions

- There should not be a conditional to determine if there needs to be a `'0'`
  prepended when formatting the `string` output
- The internal state can be one or two values, but they should be a `number`
- It's better to always have a clock with correct internal values, and not
  delay "fixing" these values until it's time to compare or format the output
- `minus` should call `plus` with a negative value, or vice-versa
