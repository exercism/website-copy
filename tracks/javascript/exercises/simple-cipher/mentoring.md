# Mentoring

This exercise focuses on
- DRYing up an implementation
- Maintainability ([magic numbers](https://en.wikipedia.org/wiki/Magic_number_(programming)), variable naming)
- Strings as characters and ["charCode"](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/String/charCodeAt)
- [Modulo arithmetic](https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/what-is-modular-arithmetic)

## Reasonable solutions
```javascript
const ALPHABET = 'abcdefghijklmnopqrstuvwxyz';
const ALPHABET_LENGTH = ALPHABET.length;
const FIRST_CHAR_CODE = ALPHABET.charCodeAt(0);
const RANDOM_KEY_LENGTH = 100;
const VALID_KEY_PATTERN = /^[a-z]+$/;

export class Cipher {
  static generateRandomKey() {
    let concattedKey = '';
    for (let i = 0; i < RANDOM_KEY_LENGTH; i++) {
      concattedKey += Cipher.randomChar();
    }
    return concattedKey;
  }

  static randomChar() {
    return String.fromCharCode(
      Math.floor(Math.random() * ALPHABET_LENGTH) + FIRST_CHAR_CODE
    );
  }

  constructor(key) {
    this.key = (key === undefined && Cipher.generateRandomKey()) || key;
    this.encode = this.process.bind(this, 1);
    this.decode = this.process.bind(this, -1);
  }

  shiftBy(index) {
    return this.key.charCodeAt(index % this.key.length) - FIRST_CHAR_CODE;
  }

  process(direction, input) {
    const outputLength = input.length;
    let output = '';
    for (let i = 0; i < outputLength; i++) {
      output += String.fromCharCode(this.shiftCharCode(input.charCodeAt(i), direction, i));
    }
    return output;
  }

  shiftCharCode(charCode, direction, index) {
    const shiftValue = direction * this.shiftBy(index);
    return ((charCode - FIRST_CHAR_CODE + shiftValue + ALPHABET_LENGTH) % ALPHABET_LENGTH)
      + FIRST_CHAR_CODE;
  }
}
```
### Boilerplate setup
Encourage extracting constants, instead of recreating alphabets or constants over and over.
- Instead of `ALPHABET`, `'a'.charCodeAt(0)` and `'z'.charCodeAt(0)` can be used.
- Discourage cryptic constant names, see suggestions.

### Key generation
Using `Array.from` with a `mapFn` (slower, but idiomatic with streams)
```javascript
static generateRandomKey() {
  return Array.from(Array(RANDOM_KEY_LENGTH), Cipher.randomChar).join('');
}
```
> If a student uses `Array.from` followed by `Array#fill` or `Array(n)` followed by `Array#fill`, point them to `Array.from` with `mapFn`.

Using `Array.from` with a `String.fromCharCode(...varags)` (slower but idiomatic)
```javascript
static randomChar() {
  return Math.floor(Math.random() * ALPHABET_LENGTH) + FIRST_CHAR_CODE);
}

static generateRandomKey() {
  const result = String.fromCharCode(
    ...Array.from(Array(RANDOM_KEY_LENGTH), Cipher.randomChar)
  );
```

### Encoding / Decoding
Using `String#split` (slower, but idiomatic with streams):

```javascript
  process(direction, input) {
    return input.split('')
      .map((letter, i) => String.fromCharCode(this.shiftCharCode(letter.charCodeAt(0), direction, i)))
      .join('');
  }
```
> Instead of `String#split`, `String#replace(/./g)` or `[...String]` can be used.

## Common suggestions
- When going for performance, at time of writing these notes, a `for` loop with string concatenation, _always_ trumps any form of `String#split` + `Array#join`, `Array#map` or `Array#reduce`: [Benchmarks](https://run.perf.zone/view/Random-key-generation-1542819336492).
- It's perfectly fine if the static methods are actually `const` or named `function` outside of the class.
- In transformation: replace `indexOf(alphabet)` and `indexOf(key)` with `charCodeAt(0)`, as `includes` is `O(n)` and transformation then is `O(n*m)` where `m` is the alphabet length / key length.
- In encoding / decoding, make sure they clean up the functions so much that they are exactly the same except for a single `-` and `+` for shifting. Then you can reduce that via the talking points.

## Talking points
- A string is like an array of bytes (ASCII `charCode`). You can represent characters as numbers and do math on it.
- DRY-up `encode`/`decode`:
  - `a + b` is the same as `a + (1 * b)`
  - `a - b` is the same as `a + (-1 * b)`
  - If you use a _direction_ variable as input, you can remove flags/conditionals.
  - DRYing up the algorithm makes it also more extendable. You could easily change it now to shift by 2 or 3.
- Things that look nice `Array.from` / `Array#map` are not always as fast as simple `for` loops. Depends on JS engine and babel too (!!). If you want to optimise, always do a benchmark. Don't "just" optimise it.
- Negative numbers in JavaScript are different than in other numbers in the way that the negative bit is not part of arithmic. In other languages negative modular arithmic works as expected, but in JavaScript you need a trick:
  - `-2 % 4` should be the same as `2 % 4` (e.g. check in Ruby), but it's not. So instead shift it to be positive:
  - `(-2 + 4) % 4` is the same as `(-2 + 4 + 4) % 4` is the same as `(x + n * m) % m`, because that's how modulo works
  - If you always add the "length" (`m`), the result is always positive, and you don't need to check if the `result < 0`
  - If the student has `result < FIRST_CHAR_CODE`, they must shift the result first. Math is easier from `0` than from  `0 + a`
