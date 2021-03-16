# Mentoring

This exercise introduces:
- floating point math
- rounding via [`Math.round`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/round)
- rounding via [`Number#toFixed`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed) with explicit casting using [`Number` as a function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#Using_Number_to_convert_a_Date_object)

Additionally there are many solutions but they all have cons and pros. The
Javascript implementation is to generify the implementation using a map and the
prototype, but that doesn't _quite_ work with the TypeScript typing system.

### Reasonable Solutions

A student may either assign `1` to the orbital period of Earth, or assign
`31557600` and re-calculate every other period to be in seconds.

#### Age given a period
```typescript
const EARTH_YEAR_IN_S = 31557600

function ageInPeriod(period: Readonly<number>): number {
  return +(this.seconds / EARTH_YEAR_IN_S / period).toFixed(2)
}
```

A student may also round using `Math.round(age * 100) / 100` or explicitly
calling `Number(string)` to cast.

#### Conversion methods
There are many ways to implement this -- you should approve any method correctly
using one of the three below, but note the pros and cons of using these methods.

A way to define the constant orbital periods is to create all the methods right
on the class like this:

```typescript
  onMercury() { return this.ageInPeriod(0.2408467) }
  onVenus() { return this.ageInPeriod(0.61519726) }
  onEarth() { return this.ageInPeriod(1) }
  onMars() { return this.ageInPeriod(1.8808158) }
  onJupiter() { return this.ageInPeriod(11.862615) }
  onSaturn() { return this.ageInPeriod(29.447498) }
  onNeptune() { return this.ageInPeriod(164.79132) }
  onUranus() { return this.ageInPeriod(84.016846) }
}
```

The pros is that autocomplete works, there is no `any` and it's easy to see if
a method is missed (in the tests you'll see a red wobbly). The con is that the
business logic (calculation) is not seperate from the input, and that adding
pluto or the likes requires slightly more work than adding a name + number in
a constant defined elsewhere. However, this is space -- it's all pretty stable.

The method above is _preferred_ over a generic mapped type:

```typescript
const ORBITAL_PERIODS = {
  Mercury: 0.2408467,
  /*...*/
}

class SpaceAge {
    [k: string]: any;
    public seconds: number

    constructor(seconds: Readonly<number>) {
        this.seconds = seconds

        Object.entries(ORBITAL_PERIODS).forEach(([planet, period]) => {
            this[`on${planet}`] = () => this.ageInPeriod(period)
        })
    }
}
```

This generic `[k: string]` does _not_ autocomplete, does _not_ catch typos and
other issues and accepts methods (keys) that don't exist on the resulting type.

_If_ someone implements it like this, make sure that don't have `any` as the
value, but rather `() => number`, which at least makes the typing show up when
using the class, but you should note that whilst it's nice to dynamically
generate these, it's not TS-friendy.

Finaly, there are ways to actually make typescrypt auto complete and separating
the input from the business logic, one of which is listed below with comments
at the type definitions what they are used for:

```typescript
const EARTH_YEAR_IN_S = 31557600

const ORBITAL_PERIODS = {
  onEarth: 1,
  onMercury: 0.2408467,
  onVenus: 0.61519726,
  onMars: 1.8808158,
  onJupiter: 11.862615,
  onSaturn: 29.447498,
  onUranus: 84.016846,
  onNeptune: 164.79132
}

type AgeOnPlanetFn = () => number

// This makes a mapping of each key in our periods map (onEarth, onXXX) and
// sets its value to a function that returns the known seconds in the age of
// that planet.
//
interface ISpaceAge extends Record<keyof typeof ORBITAL_PERIODS, AgeOnPlanetFn> {
  seconds: number
}

// This mimics a class SpaceAge, but its constructor actually returns the mapped
// type ISpaceAge listed above.
//
interface SpaceAge {
  new(number: number): ISpaceAge
}

// At any point in the iteration, the only thing we know about result is that it
// has seconds.
type ISpaceAgeConstruction = Partial<ISpaceAge> & Pick<ISpaceAge, 'seconds'>

const SpaceAge = function(number: Readonly<number>): ISpaceAge {
  return Object.entries(ORBITAL_PERIODS)
    .reduce((result: ISpaceAgeConstruction, [name, period]) => ({
        ...result,
        [name]: function ageOnPlanet() {
          return Math.round(this.seconds / EARTH_YEAR_IN_S / period * 100) / 100
        }
      }),
      { seconds: number }
    ) as ISpaceAge

// A function may not be called as a class by default in TypeScript. This double
// cast makes it anything followed by a class. In later version of TS casting to
// unknown is prefered over this cast to any.
//
} as any as SpaceAge

export default SpaceAge
```

The pro is that `autocomplete` works, there is no `any` and there is separation
between input and logic, but the con is that we can't rely on TS to make sure
the implmentation of `SpaceAge` is correct, as the cast to `any` and then
`SpaceAge` is necessary.

#### Note about future versions
The JS  version of this exercise does mutate `instance.seconds`. With the
addition of that test and behaviour, solutions with arrow functions and a `this`
inside will break with the new tests. If a student is _not_ using `readonly` you
may point this out, but don't punish them as their solution _will_ work with the
newer test suite, should this change also come to TypeScript.


### Common suggestions
- If a student uses `any`, suggest explicit return types / value types.
- If a student uses [`Object.keys`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys) followed by a `forEach`, `reduce` or `map` looking up the `key`, suggest [`Object.entries`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/entries)

### Talking points
These don't make for a make-or-break comment, but if you're having a discussion you could point out different methods of
rounding to x digits:
- If a student is rounding via `Math.round(age  100) / 100`, introduce them to [`Number#toFixed`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed) and [`Number(other)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#Using_Number_to_convert_a_Date_object)
- If a student is rounding via `Number(age.toFixed(2))`, explain they could have used [`Math.round()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/round)

Since the dynamically created, staticly typed version is so complex, only talk
about it if the student explicitly asks how they could create such a solution.
