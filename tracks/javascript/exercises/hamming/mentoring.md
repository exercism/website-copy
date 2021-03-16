# Mentoring

This exercise focuses on:
- control flow loops: how to _iterate_ through two collections and how to _count_ based on a condition

## Reasonable solutions
```javascript
export function compute(leftStrand, rightStrand) {
  const { length } = leftStrand;
  if (length !== rightStrand.length) {
    throw Error('left and right strands must be of equal length');
  }

  let distance = 0;
  for (let i = 0; i < length; i++) {
    distance += leftStrand.charCodeAt(i) !== rightStrand.charCodeAt(i);
  }
  return distance;
}
```
Variations include `String#charAt(i)` and `String#[i]` (similar speed)

Using `continue` (similar speed):
```javascript
if (leftStrand.charCodeAt(i) === rightStrand.charCodeAt(i)) {
  continue;
}
distance += 1;
```

Explicit addition with ternary (similar speed):
```javascript
distance += leftStrand[i] === rightStrand[i] ? 0 : 1
```
Variations include re-assignment using `? distance : distance + 1`

### Using streams
Vanilla JavaScript doesn't have a `Array#zip(array)` or `Enumerable#count(expression)` function, yet, but it can still be attempted by using `split` with `reduce` or `replace`. These solutions work, but are a factor 5-10 slower. You might want to challenge a student to use a for loop. **Note** that performance is heavily impacted by the JavaScript engine and things like bable/bubble implementation/version.

Stream processing with `reduce` (significantly slower, but `reduce` is a common method to `count`):
```javascript
leftStrand.split('')
          .reduce((count, letter, index) => count += letter !== rightStrand[index])
```
Variations include `[...leftStrand].reduce()`

Difference "mapping" using `replace` (significantly slower, more difficult to maintain):
```javascript
leftStrand.replace(/./g, (letter, index) => rightStrand[index] === letter ? '' : letter).length;
```
Variations include `leftStrand.split('').filter()` and `[...leftStrand].filter()`

### Common suggestions
- When going for performance, at time of writing these notes, a `for` loop, counting each difference in a mutable variable, _always_ trumps any form of `String#split` + `String#replace` or `Array#reduce`: [Benchmarks](https://run.perf.zone/view/Count-differences-between-strings-1542904507660).


### Talking points
- If a student uses streams:
  - `reduce` and `filter` are better candidates than `forEach` (use a for loop)
  - These functions have second arguments `index`. Don't do manual bookkeeping of an index
- If a student uses a for loop:
  - `continue` is nice to mention
  - arithmic with thruthy and falsy values can be mentioned

