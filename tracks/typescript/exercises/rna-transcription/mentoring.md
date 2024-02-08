# Mentoring

This exercise focuses on
- [`String`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) iteration ([`String#replace`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace), [`String#split`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/split))
- [`Object`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)/`Map`

## Reasonable solutions

```typescript
const TRANSCRIPTION = {
  C: 'G',
  G: 'C',
  A: 'U',
  T: 'A',
};

function invalidInput() {
  throw new Error('Invalid input DNA.')
}

export class Transcriptor {
  public toRna(sequence: string): string {
    return sequence
      .split('')
      .map(nucleotide => TRANSCRIPTION[nucleotide] || invalidInput())
      .join('')
  }
}

```
Variations include `Set` or `Map` with `#get`, which are valid!

String destructuring can also be used:
```typescript
return [...sequence].map(/**/).join('')
```

[String#replace](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace) can also be used:
```typescript
return sequence.replace(/./g, (nucleotide) => /* */)
```

Variations include replacing only the "known" nucleotides:
```typescript
sequence.replace(/[CGAT]g/, (nucleotide) => /* */)
```

## Common suggestions

- Use an [`Object`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object) to keep track of the mapping instead of conditionals.
- Use iteration via [`String#split`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/split) or [`String#replace`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace) instead of using `for`/`forEach` with [`Array#push`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push)
- Discourage [`Array#reduce`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce) for this particular solution, because it creates a lot of intermediary strings (more than the `split` approach), except if the rest of the solution is correct (then you can mention it but approve). Using `reduce` requires more interpretation by the reader to follow, change and maintain.
- Discourage [`String#substring`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/substring) with foreach iteration, because character iteration via `split('')` is more idiomatic and maintainable than `substring` with 1. Using `split('')` requires less interpretation by the reader to follow, change and maintain.

## Talking points

- Encourage streams because it's harder to use intermediary variables (which can lead to bugs) and forces "one-by-one" approach. It is easier to explain the [`Object`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object) solution over multiple conditionals when it's a stream.
- If a student uses an `Object`, point them to `falsy` values.
- Highlight TypeScript's ability to infer types automatically, reducing the need for explicit type declarations in many cases.
  - For example, TypeScript can infer the types of objects like TRANSCRIPTION without the need for explicit type declarations, making code more concise and readable. For instance, the following code:
    ```
    const TRANSCRIPTION = {
      C: 'G',
      G: 'C',
      A: 'U',
      T: 'A',
    };
    ``` 
    is functionally equivalent to the more verbose version with explicit type declarations:
    ```
    type AllowedStrand = "A" | "C" | "G" | "T";
  
    type Nucleotides = {
      [key in AllowedStrand as string]: string;
    };
    
    const adnTranscribedRna: Nucleotides = {
      A: "U",
      C: "G",
      G: "C",
      T: "A"
    };
    ```
    This showcases TypeScript's ability to intelligently deduce types from the structure of the code, simplifying development and improving developer productivity.
