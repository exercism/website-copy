# Mentoring

This exercise focuses on
- [`String`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) iteration ([`String#replace`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace), [`String#split`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/split))
- [`Object`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)/`Map`

## Reasonable solutions

```javascript
const TRANSCRIPTION = {
  C: 'G',
  G: 'C',
  A: 'U',
  T: 'A',
};

export function toRna(sequence) {
  return sequence
    .split('')
    .map(nucleotide => TRANSCRIPTION[nucleotide])
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

Variations include replacing only the "known" nucleotides:
```javascript
sequence.replace(/[CGAT]/g, (nucleotide) => /* */)
```

### Note

There are versions that check for valid Input DNA (which has since been removed), meaning 
they include the following or variations:
```javascript
function invalidInput() {
  throw new Error('Invalid input DNA.')
}

/*...*/
  .map(nucleotide => TRANSCRIPTION[nucleotide] || invalidInput())
/*...*/
```

Since the error handling is now unnecessary, it will be considered defensive programming. The
student does _not_ need to validate the input, as the tests no longer ask for it.

### Common suggestions

- Use an [`Object`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object) to keep track of the mapping instead of conditionals.
- Use iteration via [`String#split`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/split) or [`String#replace`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace) instead of using `for`/`forEach` with [`Array#push`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push)
- Discourage [`Array#reduce`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce) for this particular solution, because it creates a lot of intermediary strings (more than the `split` approach), except if the rest of the solution is correct (then you can mention it but approve). Using `reduce` requires more interpretation by the reader to follow, change and maintain.
- Discourage [`String#substring`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/substring) with foreach iteration, because character iteration via `split('')` is more idiomatic and maintainable than `substring` with 1. Using `split('')` requires less interpretation by the reader to follow, change and maintain.

### Talking points

- Encourage streams because it's harder to use intermediary variables (which can lead to bugs) and forces "one-by-one" approach. It is easier to explain the [`Object`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object) solution over multiple conditionals when it's a stream.
- If a student uses an `Object`, point them to `falsy` values.
