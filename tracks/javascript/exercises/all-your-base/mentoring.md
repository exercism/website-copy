# Mentoring

### Reasonable solutions

The most important thing is that the student has to implement the algorithm(s)
themselves. This means no libraries and no `.toString(base)`.

```javascript
function assertDigits(digits, base) {
  if (
    digits.length === 0
    || (digits[0] === 0 && digits.length !== 1)
    || digits.some(d => d < 0 || d >= base)
  ) {
    throw new Error('Input has wrong format')
  }
}

function assertBase(base, name) {
  if (base <= 1 || Math.floor(base) !== base) {
    throw new Error(`Wrong ${name} base`)
  }
}

function toBase10number(digits, sourceBase) {
  return digits
    .reverse()
    .reduce((result, digit, position) => result + digit * (sourceBase ** (position)))
}

function toBaseDigits(n, nextBase) {
  const result = []

  do {
    result.unshift(n % nextBase)
    n = Math.floor(n / nextBase)
  } while (n > 0)

  return result
}

export function convert(digits, base, nextBase) {
  assertBase(base, 'input')
  assertBase(nextBase, 'output')
  assertDigits(digits, base)

  return toBaseDigits(toBase10(digits, base), nextBase)
}
```

There are various ways to approach this exercise. In general, it should consist
of the following elements:

- validating the input
- validating the basis
- convert the value to base 10
- convert the value to an arbitrary base

Note: the two conversion steps _can_ be reduced to a single step, by
calculating the "base" between the two. However, this is usually somewhat
harder to comprehend. Take note that this is a possibility, and a valid one.

#### Converting to base 10

There are various approaches, but the two most concise ones, derived from
compsci and mathematics, are as follows:

```javascript
digits.reduce((result, digit) => result * inputBase + digit, 0);
```

This effectively calculates the value at a significant position, and then
pushes the whole value one digit to the left by multiplying the current
value by the base, before calculating the current digit's value. This means,
looking from the left, counting towards the right, a digit at the "3rd"
significant position will be multiplied 0 times, the digit at the "2nd"
significant position will be multiplied 1 time and the digit at the "1st"
significant position will be multiplied twice.

```text
[4, 2, 1, 6]

    * 10 + 4 = 0    + 4
4   * 10 + 2 = 40   + 2
42  * 10 + 1 = 420  + 1
421 * 10 + 6 = 4210 + 6
4216
```

The example above converts "4216" from base 10 to base 10 (to demonstrate).

```javascript
digits
  .reverse()
  .reduce((result, digit, position) => result + digit * (base ** (position)))
```

This takes the reverse approach, literally, and increments the result by the
value of the digit, working from right to left.

```text
[4, 2, 1, 6]

  0 + 6 * (10 ** 0) = 6 * 1    +   0 =    6 +   0
  6 + 1 * (10 ** 1) = 1 * 10   +   6 =   10 +   6
 16 + 2 * (10 ** 2) = 2 * 100  +  16 =  200 +  16
216 + 4 * (10 ** 3) = 4 * 1000 + 216 = 4000 + 216

4216
```

The example above converts "4216" from base 10 to base 10 (to demonstrate).
