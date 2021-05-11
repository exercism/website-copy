# Mentoring

This exercise introduces:
- floating point math
- rounding via [`Number#toFixed`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed) with explicit casting using [`Number` as a function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#Using_Number_to_convert_a_Date_object)

## Reasonable solutions

Reasonable solutions define all the periods in a map (object):

```javascript
const EARTH_YEAR_IN_S = 31557600
const ORBITAL_PERIODS = {
  earth: 1,
  mercury: 0.2408467,
  venus: 0.61519726,
  mars: 1.8808158,
  jupiter: 11.862615,
  saturn: 29.447498,
  uranus: 84.016846,
  neptune: 164.79132
}
```

If they use capitalized names, a function to map the input `planet` name to the
key or a function to map from that name to the orbital period is preferred:

```javascript
function getOrbitalPeriod(planet) {
  const [firstLetter, ...rest] = planet
  return ORBITAL_PERIODS[[firstLetter.toUpperCase(), ...rest].join('')]
}
```

In the above case, the destructuring solution is equivalent to using an indexer
on `planet[0]` and/or substringing.

Finally, converting from the input age in seconds to the output:
```javascript
export function age(planet, earthAgeInS) {
  return Number((earthAgeInS / EARTH_YEAR_IN_S / getOrbitalPeriod(planet)).toFixed(2))
}
```

### Changelog

Earlier versions of this exercise required (for a correct implementation) to dynamically create functions on the
prototype, and expected a string output, instead of a number (rounded on two decimals):

```javascript
Object.entries(ORBITAL_PERIODS).forEach(([planet, period]) => {
  SpaceAge.prototype[`on${planet}`] = function ageOnPlanet() {
    return this.ageInPeriod(period)
  }
})
```

Even earlier versions of this exercise expected a property `instance.seconds`; which later was tested for mutability
breaking solutions with arrow functions and a `this` inside.

If a student is on an older version, kindly suggest they update to the newer test suite.

### Common suggestions
- If they use the unary `+` or parseFloat to convert to a number, show them `Number(val)` which explicitly converts `val` to a
  number.
Here is a good example of when to make this decision:
[https://stackoverflow.com/a/13676265/5283424](https://stackoverflow.com/a/13676265/5283424)
 - If they round via `Math.round(age * 100) / 100`, introduce them to [`Number#toFixed`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed).


### Talking points
- Define `const` on the file-level and outside of function definitions if they stay constant for the duration of the
  file (as opposed to constants re-defined each function call).
- While [`Number#toFixed`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed) is much more declarative, using `Math.round` has much better performance.

