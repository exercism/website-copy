
This exercise introduces:
- floating point math
- rounding via [`Math.round`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/round)
- rounding via [`Number#toFixed`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed) with explicit casting using [`Number` as a function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#Using_Number_to_convert_a_Date_object)
- potentially the [prototype](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/prototype)

### Reasonable solutions
```javascript
const EARTH_YEAR_IN_S = 31557600

const ORBITAL_PERIODS = {
  Earth: 1,
  Mercury: 0.2408467,
  Venus: 0.61519726,
  Mars: 1.8808158,
  Jupiter: 11.862615,
  Saturn: 29.447498,
  Uranus: 84.016846,
  Neptune: 164.79132
}

export class SpaceAge {
  constructor(earthAgeInS) {
    this.seconds = earthAgeInS
  }

  get earthYears() {
    return this.seconds / EARTH_YEAR_IN_S
  }

  ageInPeriod(period) {
    return (this.earthYears / period).toFixed(2)
  }
}

Object.entries(ORBITAL_PERIODS).forEach(([planet, period]) => {
  SpaceAge.prototype[`on${planet}`] = function ageOnPlanet() {
    return this.ageInPeriod(period)
  }
})
```

It is _perfectly fine_ to write out all the methods like this:
```javascript
  onMercury() { return this.ageInPeriod(0.2408467) }
  onVenus() { return this.ageInPeriod(0.61519726) }
  onEarth() { return this.ageInPeriod(1) }
  onMars() { return this.ageInPeriod(1.8808158) }
  onJupiter() { return this.ageInPeriod(11.862615) }
  onSaturn() { return this.ageInPeriod(29.447498) }
  onNeptune() { return this.ageInPeriod(164.79132) }
  onUranus() { return this.ageInPeriod(84.016846) }
```
...which only con is that the input is not separated from the logic and its just a bit more characters. If a student has
implemented it as such, you should approve that solution, but you may always point out how to generate these dynamically
as it can result into interesting solutions using the prototype.

Alternative solutions include permutations of the following:
- The getter `get earthYears` can be inlined inside `ageOn`
- The instance function `ageOn` can be inlined when generating `ageInPeriod`
- The function `ageInPeriod` does _not_ need to be named

Another solution is returning an object from the constructor:

```javascript
function makeSpaceAge(initial) {
  return Object.entries(ORBITAL_PERIODS)
    .reduce((result, [planet, period]) => ({
      ...result,
      [`on${planet}`]: function ageOnPlanet() {
        return +((this.seconds / EARTH_YEAR_IN_S / period).toFixed(2))
      }
    }), initial)
}

export class SpaceAge {
  constructor(earthAgeInS) {
    this.seconds = earthAgeInS
    return makeSpaceAge({ seconds: earthAgeInS })
  }
}
```

#### Note about earlier versions
Earlier versions of this exercise did not mutate `instance.seconds`. With the addition of this test, solutions with
arrow functions and a `this` inside usually break with the new tests. If a student is on an older version, kindly
suggest they update to the newer test suite.

### Common suggestions
- If a student wrote out all the `onXXX` functions, explain the [prototype](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/prototype)
- If a student uses [`Object.keys`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys) followed by a `forEach`, `reduce` or `map` looking up the `key`, suggest [`Object.entries`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/entries)

### Talking points
These don't make for a make-or-break comment, but if you're having a discussion you could point out different methods of
rounding to x digits:
- If a student is rounding via `Math.round(age  100) / 100`, introduce them to [`Number#toFixed`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed) and [`Number(other)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#Using_Number_to_convert_a_Date_object)
- If a student is rounding via `Number(age.toFixed(2))`, explain they could have used [`Math.round()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/round)


