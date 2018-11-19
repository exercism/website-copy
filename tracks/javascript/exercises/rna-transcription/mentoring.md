This exercise focuses on
- [`String](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) iteration (`replace`, `split`)
- [`Object`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)/`Map` and its "not-found" behaviour (`undefined`)
- `undefined` is falsy

## Reasonable solutions

```javascript
const TRANSCRIPTION = {
  C: 'G',
  G: 'C',
  A: 'U',
  T: 'A',
};

function invalidInput() {
  throw new Error('Invalid input DNA.')
}

export function toRna(sequence) {
  return sequence
    .split('')
    .map(nucleotide => TRANSCRIPTION[nucleotide] || invalidInput())
    .join('')
}
```
Variations include `Set` or `Map` with `#get`, which are valid!

String destructuring can also be used:
```javascript
return [...sequence].map(/**/).join('')
```

[String#replace](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace) can also be used:
```javascript
return sequence.replace(/./g, (nucleotide) => /* */)
```

Validation can be tested with a [pattern](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp/test) first:
```javascript
if (/[^CGAT]/.test(sequence)) {
  throw new Error('Invalid input DNA.')
}
```
Upside of this is that it fails fast; downside of this is that it iterates the string twice.

### Note
Older versions did not check for valid Input DNA, so they include solutions like:
```javascript
sequence.replace(/[CGAT]g/, /* */)
```

These are no longer passing the tests.

## Common suggestions
- Use an [`Object`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object) to keep track of the mapping instead of conditionals.
- Use iteration via `split` or `replace` instead of using `for` with [`Array#push`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push)
- Discourage [`Array#reduce`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce) for this particular solution, because it creates a lot of intermediary strings (more than the `split` approach), except if the rest of the solution is correct (then you can mention it but approve). Using `reduce` requires more interpretation by the reader to follow, change and maintain.
- Discourage [`String#substring`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/substring) with foreach iteration, because character iteration via `split('')` is more idiomatic and maintainable than `substring` with 1. Using `split('')` requires less interpretation by the reader to follow, change and maintain.

## Talking points
- Encourage streams because it's harder to use intermediary variables (which can lead to bugs) and forces "one-by-one" approach. It is easier to explain the `Object` solution over multiple conditionals when it's a stream.
- If a student uses an `Object`, point them to `falsy` values.
