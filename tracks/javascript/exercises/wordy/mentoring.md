# Mentoring

### Reasonable solutions

There are many _valid_ solutions to this problem. If the student has written
something completely different than the options listed below, do not dismiss it.
At this point in the track, we can expect them to have developed their own
style. However, follow the guidelines listed in this document.

> **Note**: solutions using `eval` are usually very concise, but most of the
> time neither safe (they don't whitelist the tokens) or meant to be. If a
> student has done this, encourage them to implement it again without `eval`,
> but depending on the solution you can approve it regardless.

The main ways of implementation consist of two forms:
- Extensively using `replace` or `match` and then directly applying the operator
- Tokenizing the input (parsing) and then executing the tokens

#### Actions / Operators

There are four (4) operators (and one extra if you include `cubed`) that should
be defined as a function, preferably in a lookup operator name to action/
closure/anonomous function:

```javascript
const OPERATIONS = {
  'plus': (value, operand) => value + operand,
  'minus': (value, operand) => value - operand,
  'multiplied by': (value, operand) => value * operand,
  'divided by': (value, operand) => value / operand,

  // optional
  'cubed': (value) => value ** 2
}
```

In case of a tokenizer and lazy execution pattern, this could also be
represented using classes:
```javascript

class BinaryOperator {
  constructor(action) {
    this.action = action
  }

  call(context) {
    return this.action(context.value, context.next)
  }
}

const OPERATIONS = {
  plus: new BinaryOperator((value, next) => value() + next()),
  minus: new BinaryOperator((value, next) => value() - next()),
  ...
}
```

Discourage inline operations with `if/else` trees or `switches`.

#### Parsing / Tokenization

There are two key patterns for matching:
- `LITERAL_NUMBER`: `/(-?\d+)/`
- `OPERATORS`: `Object.keys(OPERATIONS).join('|')`

In order to parse the question correctly, a student may:
- match the first number and store it as initial value, then match
  `(${OPERATORS})(${LITERAL_NUMBER})` and replace the initial value constantly,
- match ``(${LITERAL_NUMBER})(${OPERATORS})(${LITERAL_NUMBER})`, calculate the
  result and replace it with the result, until it finds the `?` or no more
  `OPERATORS`,
- parse all `OPERATORS` and `LITERAL_NUMBER` first into tokens and then
  executing the result to get to a new answer.

The key here is to _not_ duplicate these patterns.

Discourage `eval`.

#### Traversing the question

Valid methods of traversing the question are:
- splitting on a space, and slicing per 3 (or 2 depending on implementation),
  followed by a `reduce`.
  ```javascript
  tokens.slice(3).reduce((prev, slice) => parseSlice(prev slice))
  ```

- using a `while(true)` or `do while(pattern)` calling `replace` each time to
  do part of the calculation and replace it with the new number.
  ```javascript
  do {
    question = question.replace(TRIPLE_PATTERN, (_, value, operator, operand) =>
      (OPERATIONS[operator](+value, +operand)).toString()
    )
  while(OPERATOR_PATTERN.test(question))
  ```

- filter to get all operators and all literals separately and then using a loop
  (`forEach` or `reduce`) to execute all operators.
  ```javascript
  tokens.filter(token => (token instanceof Operator)).forEach((token) => {
    context.call(token)
  })
  ```

Discourage `if/else` trees or `switches`.

#### Error throwing

Unfortunately the current implementation of checking the error is incorrect and
may cause the student plenty of issues (We are working towards changing this).
The only two valid ways to make the tests pass currently are:

```javascript
function ArgumentError() {}

// or better
class ArgumentError extends Error {}
```

The student can _not_ assign a dynamic message at this moment, because the test
is less than perfect. Help them out if they don't get this as it's not vital to
the exercise.

### Common suggestions

- Suggest replacing a `switch` or `if/else` tree on the operator name with a
  lookup map.
- Suggest DRY-ing up the patterns, operators.

### Talking points

- Extensibility of the solution; can new operators be added?
- Implementation of cubed; can it be done with the current implementation?
- The running time of the algorithm; nested loops?
- Reliability of the algorithm; are spaces significant?
