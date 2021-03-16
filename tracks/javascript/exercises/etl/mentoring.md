# Mentoring

This exercise focuses on:
- control flow loops: _nested_ data structure iteration
- integers: converting a `String` key to a `Numeric` value
- maps: [`Object.keys`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys), [`Object.entries`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/entries)
- transforming: [`Array#forEach`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach), [`Array#reduce`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/reduce); how to move keys and values around; how to transform strings [`toLowerCase`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/toLowerCase)

## Reasonable solutions
```javascript
export default function transform(legacyScores) {
  const scores = {};
  Object.keys(legacyScores)
    .forEach((points) => {
      legacyScores[points].forEach((letter) => {
        scores[letter.toLowerCase()] = +points;
      });
    });
  return scores;
}
```
Variations include `parseInt`

Using [`Object.entries`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/entries) with nested [`Array#forEach`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach) (50% slower):
```javascript
export default function transform(legacyScores) {
  const scores = {};
  Object.entries(legacyScores)
    .forEach(([points, letters]) => {
      letters.forEach((letter) => {
        scores[letter.toLowerCase()] = +points;
      });
    });
  return scores;
}
```
Variations include `.reduce((scores, [key, value]) => )` instead of `.forEach([] => )`

Using [`for ... in ...`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for...in) with nested `Array#forEach` (66% slower):
```javascript
export default function transform(legacyScores) {
  let scores = {};
  for (let points in legacyScores) {
    if (!legacyScores.hasOwnProperty(points)) {
      continue;
    }
    legacyScores[points].forEach(i => scores[i.toLocaleLowerCase()] = +points);
  }
  return scores;
}
```
Variations include replacing the nested [`Array#forEach`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach) and/or the [`for ... in ...`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for...in) loop with a `for ...;...;...` loop.

## Common suggestions
- When going for performance, at time of writing these notes, [`Object.keys`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys) is significantly faster than [`Object.entries`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/entries) and [`Array#forEach`]](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach) is faster than [`for ... in ...`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for...in) / `for ;;;` loops: [Benchmarks](https://run.perf.zone/view/Nested-object-iteration-1542907930560).


## Talking points
- If a student uses [`for ... in ...`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for...in):
  - Explain that this iterates over all properties, so you _SHOULD_ use the [`Object#hasOwnProperty`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/hasOwnProperty) check.
  - Using [`Object.keys`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys), [`Object.values`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/values) or [`Object.entries`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/entries) and iterating over the resulting array is the idiomatic way.
