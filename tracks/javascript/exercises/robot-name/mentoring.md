# Mentoring

### Reasonable solutions

This exercise can be solved in two ways. If the student does _not_ enable the
final test, an implementation using random generation at query time suffices,
with an extra point if they track the generated names to ensure no duplicates
(impossibility vs improbability).

The solution below would even pass the final test, but it can take _hours_ so
normally it'd time out because of all the duplicate generations:

```javascript
const usedNames = new Set()

function randomBetweenInclusive(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function randomDigit() {
  return randomBetweenInclusive(100, 999)
}

const ASCII_A = 'A'.charCodeAt(0)
function randomLetter() {
  return String.fromCharCode(randomBetweenInclusive(ASCII_A, ASCII_A + 26))
}

function generateName() {
  const name = [
    randomLetter(),
    randomLetter(),
    randomDigits()
  ].join('')

  if (usedNames.has(name)) {
      return generateName()
  }

  usedNames.add(name)
  return name
}

export class Robot {
  constructor() {
    this.reset()
  }

  get name() {
    return this._name
  }

  reset() {
    this._name = generateName()
  }
}
```

Variations include:
- generating a number between `10` and `36` and using `toString(36)` in order to get a letter
- generating each digit separately
- using a `Hash` to keep track of `usedNames`

Note: "predictable" in the requirement below does not imply crypto-strong randomness.
There's no need to use the `crypto` API; either that or `Math.random()` is fine.

> The names must be random: they should not follow a predictable sequence.

For students going the extra mile, all names should be generated up front,
shuffled and then sequentially accessed (pointer, pop or shift):
```javascript
const LETTERS = [...'QWERTYUIOPASDFGHJKLZXCVBNM']
const NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]

const ALL_NAMES = []

LETTERS.forEach((a) => {
  LETTERS.forEach((b) => {
    NUMBERS.forEach((c) => {
      NUMBERS.forEach((d) => {
        NUMBERS.forEach((e) => {
          ALL_NAMES.push([a, b, c, d, e].join(''))
        })
      })
    })
  })
})

const shuffled = ALL_NAMES
let shuffledPointer = -1

// Fisher-Yates shuffle in order to randomly sort the current names. Normally
// you would return a new array, but this function can be used to re-shuffle.
function shuffleNames() {
  let j
  let x
  let i

  for (i = shuffled.length - 1; i > 0; i -= 1) {
    j = Math.floor(Math.random() * (i + 1))
    x = shuffled[i]
    shuffled[i] = shuffled[j]
    shuffled[j] = x;
  }
}

function generateName() {
  shuffledPointer += 1
  if (shuffledPointer > shuffled.length) {
    throw new Error('Can not generate another name because all the names have been used.')
  }
  return shuffled[shuffledPointer]
}

// Initial shuffle
shuffleNames()

export class Robot {
  constructor() {
    this._name = generateName()
  }

  get name() { return this._name }

  reset() {
    this._name = generateName()
  }
}
```

Variations include:
- for loop for the generation and iterating 100 through 999 for the digits
- mutating the "possible names" array (popping / shifting / splicing)

### Common suggestions
- If a student uses an `Array` instead of a `Set` or `Hash` for the `usedNames`, suggest they change it
- If a student is not correctly generating the names, suggest they fix it
- If a student defines a setter explicitly, at least notify them that it's uncessary, but does allow for a custom error

### Talking points
- See if they want to tackle the final test which generates all names:
  - Steer them first towards why the tests take forever with a `rand` implementation
  - Help them calculate how many names are possible and help them realise that this is a relatively small number
  - Suggest it to be exhaustive
- What are the upsides vs downsides from both implementations
  - Start-up time
  - Low usage vs. high usage (of the Robot class)
  - Query time (cost of duplicates)
  - Memory usage over time
  - The exhaustive solution allows for "program-wide" resets by moving back the pointer / duplicating the original names + reshuffling
