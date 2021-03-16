# Mentoring

## Reasonable solutions

There are two main ways to solve this:
- using bitwise operations
- converting to a bitstring and testing for `'1'`

## Bitwise solution

```javascript
const OPERATIONS = [
  'wink',               // idx: 0 => 1 << 0 => 0b00000001 (1)
  'double blink',       // idx: 1 => 1 << 1 => 0b00000010 (2)
  'close your eyes',    // idx: 2 => 1 << 2 => 0b00000100 (4)
  'jump'                // idx: 3 => 1 << 3 => 0b00001000 (8)
]

export function secretHandshake(sekret) {
  if (!(typeof sekret === 'number')) {
    throw new Error('Handshake must be a number')
  }

  const shake = OPERATIONS.filter((_, i) => sekret & (1 << i))
  return sekret & 16 ? shake.reverse() : shake
}
```

Note that the `sekret & 16` can also be written as `1 << 4` or `0b10000` or
`0b00010000`

### Bitstring solution

```javascript
const OPERATIONS = [
  'wink',
  'double blink',
  'close your eyes',
  'jump'
]

export function secretHandshake(sekret) {
  if (!(typeof sekret === 'number')) {
    throw new Error('Handshake must be a number')
  }

  const bits = sekret.toString(2).split('').reverse()
  const shake = OPERATIONS.filter((_, i) => bits[i] === '1')
  return bits[4] === '1' ? shake.reverse() : shake
}
```

### Common suggestions

- If a student checks for each value explicitly (as listed in the comments of
  the first solution next to the operations), point them towards [`<<` (Left Shift)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Bitwise_Operators#%3C%3C_(Left_shift)).
  There is _no need_ to use explicit checks.
- Replace `push` with `filter` or `reduce`
- Use an operations map over `switch` or `if/else` tree.

### Talking points

- Extensibility of the solution; can a new operation be added easily?
- If a student uses the `bitstring` method, start a discussing about bitwise
  operators.
