# Mentoring

This exercise introduces
- Array enumeration using [`Array#every`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/every) or
- [`Set`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Set)

## Reasonable solutions

Solutions can either use [`Array#every`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/every) with [`String#includes`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/includes) or [`Set#size`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Set/size) with
[`String#match`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/match):

```javascript
const ALPHABET = [...'qwertyuiopasdfghjklzxcvbnm']

export function isPangram(input) {
  const normalised = input.toLowerCase()
  return ALPHABET.every((letter) => normalised.includes(letter))
}
```

```javascript
const ALPHABET_SIZE = 26
const ALPHABET_TEST = /[a-z]/g

export function isPangram(input) {
  const normalised = input.toLowerCase()
  return new Set(normalised.match(ALPHABET_TEST)).size >= ALPHABET_SIZE
}
```

Alternatives include using [`String#split`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/split) to create the alphabet array.

## Common suggestions
If a student uses an array and checking the length, introduce them to [`Set`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Set).

## Talking points
If a student used [`Set`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Set), you can talk about [`Array#every`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/every) and vice versa. Make
sure you approve their solution first, because one isn't idiomatically better
than the other.
