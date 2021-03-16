# Mentoring

The point of this exercise is to teach the student to use:
- [Remainder (%)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Remainder_()), also known as modulo
- [Logical operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators)
- [Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence)

## Reasonable solutions

In the solutions below, the placement of parentheses and the order of operations is _significant_. Variations include
using a named `function` instead of an arrow function assigned to a `const`, may have extraneous wrapping parentheses,
or use helper functions:

```javascript
export const isLeap = (year) => year % 4 === 0 && (year % 100 !== 0 || year % 400 === 0);
```

```javascript
export const isLeap = (year) => !(year % 4) && !!(year % 100) || !(year % 400);
```

```javascript
function isDivisible(year, n) {
  return year % n === 0
}

const isDivisibleBy4 = (year) => isDivisible(year, 4)
const isDivisibleBy100 = (year) => isDivisible(year, 100)
const isDivisibleBy400 = (year) => isDivisible(year, 400)

export const isLeap = year => isDivisibleBy4(year) && (!isDivisibleBy100(year) || isDivisibleBy400(year))
```

The particularly clever student will use `Date`. Do not punish them for this - instead simply appreciate their ingenuity:
```javascript
// Months in Date start at 0, this tries to set the date to 29th of february and
// checks if it has rolled over to March.
export const isLeap = (year) => new Date(year, 1, 29).getMonth() === 1
```

## Common suggestions

This is used to be the first mentored exercise, but now it's one of the first side exercises. You may use this to
determine a student's skill, help them set up their test suite, and generally point out certain things. In the
JavaScript track, this exercise is not meant to be a barrier so in general, if the student has a reasonable solution not
listed above, you can approve the solution and tell them they can resubmit to improve. **Most** students will actually
keep improving:


    Hi there {name},

    Congrats on submitting your first side exercise solution for the JavaScript
    track. I have a few comments for you:

    - In Javascript, the result of an expression can be returned!
      ```javascript
      if (expressionThatMightBeTruthyOrFalsy) {
        return true
      }
      return false
      ```
      Given the example above, you can rewrite this to:
      ```javascript
      return expressionThatMightBeTruthyOrFalsy
      ```
    - You should be able to combine the if statements into a single expression
      using the [logical AND](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators) (&&)
      and [logical OR](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators) (||)
      operators.

    I'm approving your current submission so you can continue down the track,
    but feel free to iterate, improve and submit another solution. I will
    continue to mentor your future iterations.


Generally, for `leap` in JavaScript, it's okay to approve if there are one or two suggestions, but don't approve if
there is something significantly wrong.

Above you can see two common suggestions:
- Use implicit return of expressions instead of explicitly returning `true` or `false`.
- Instead of nesting `if` statements, use [Logical operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators)
  to combine multiple expressions.

Other suggestions are as follows:
- Make sure you are always running the test suite before you submit your solution. Are you having trouble setting it up?
  The installation instructions can be found [here](https://exercism.io/tracks/javascript/installation); The README.md
  of this exercise tells you how to run the tests.
- If they are testing if the `year` is a number, you can tell them that on exercism you don't need to practise defensive
  programming. If the tests only pass you numbers, you only need to handle numbers.
- If they are testing if the `year` is positive, you can tell them that negative years are also valid years.
- If they are testing the same number (`4`, `100`, `400`) more than once, explain that they should eliminate duplicate
  work as no year should ever have to be checked multiple times for the same condition. This usually results in a better
  solution overall.
- If the order of the tests is not (`4`, `100`, `400`), you can give them a mathy suggestion:

      - Mathematically your checks are not ordered optimally.
        - Consider all years and you'll see that only 25% of all years are
          divisible by 4. You probably want to test for that right away, so that
          75% of all cases evaluate to `false` before you check anything else.
        - Only 1% of all years is divisible by 100, which means that 98.97% of
          all years that are divisible by 4, are **not** divisible by 100. You
          probably want to test for that to eliminate almost any input.
        - Finally, 1.03% of all years divisible by 4 are divisible by 400. This
          should be the last test.

- If the student does _not_ use parentheses, _or_ has parentheses around the test for 4 and 100, and not around 100 and
  400, you can give them a mathy suggestion:

      - Mathematically you are testing if a year is divisible by 4 more than
        once:
        - Consider the year 1003, which is not divisible by 4.
        - In this case it _still_ checks if the year is divisible by 400, which
          can never be true.
        - You can solve this by rearranging your parentheses.

## Talking points
- If there are more than two "returns" or more than three "tests", you can talk about the two cases that return `true`:
  - A year is a multiple of 4 *and not* 100
  - A year is a multiple of 4, 100, and 400
- [Remainder (%)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Remainder_()), also known as modulo. This usually does not need explaining.
- [Logical operators (`!`, `&&`, and `||`)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators). If they use the binary forms `&`, `|`, explain how [short-circuit](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators#Short-circuit_evaluation) evaluation works.
- [Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence): unlike other languages, logical AND (`&&`) _always_ has a **higher** precedence than logical OR (`||`).
- [truthy](https://developer.mozilla.org/en-US/docs/Glossary/Truthy) and [falsy](https://developer.mozilla.org/en-US/docs/Glossary/Falsy) values in JavaScript
- Differences between loose value equality (`==`) and same-value equality (`===`)
- If a student submits one-liner with a `return`, talk about implicit return of arrow functions with
  [concise body rather than block body](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions#Function_body).

### Maintainability and performance:
Something like this ís readable and maintainable, but if a student submits this, point out resources (functions are created each invocation) and returning expression evaluations as in this example, each invocation `isDivisibleFn` is recreated, which can be fixed by inversing the curry; and all values are calculated before they are used. In fact, when `by400` is true, the rest doesn't matter, so it's a waste of CPU cycles. Applying the suggestions to this works the same when it comes to logical operators, _order of operations_ and _order of evaluation_ as per the second reasonable solution.

```javascript
function isDivisibleBy(number) {
  return mod => number % mod === 0;
}

export const isLeap = year => {
  const isDivisibleByFn = isDivisibleBy(year);
  const by4 = isDivisibleByFn(4);
  const by100 = isDivisibleByFn(100);
  const by400 = isDivisibleByFn(400);
  let isLeapResult = Boolean(by4 && !by100);
  if (by400) {
    isLeapResult = true;
  }
  return isLeapResult;
};
```

### Short circuit explanation
Some students ask something along the lines of:

> Are some expressions not evaluated if they won't effect the result?


Here is a template you can respond with:

    That is a good question. In JavaScript and Typescript, some operators have [short-circuit](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators#Short-circuit_evaluation) evaluation.

    - `a && b`
      - `a` is _always_ evaluated
      - `b` is _only_ evaluated if `a` was `truthy`, otherwise the entire expression short-circuits to whatever `a` evaluated to.
    - `a || b`
      - `a` is _always_ evaluated
      - `b` is _only_ evaluated if `b` was `falsy`, otherwise the entire expression short-circuits to whatever `a` evaluated to.

    In the wild you'll find code like this:
    ```javascript
    // only execute functionname if variable is truthy,
    //   useful for flags, or preconditions
    variable && functionname()

    // only execute functionname if variable is falsy,
    //   useful for flags, or defaults, or error cases
    variable || functionname()
    ```

    You can observe this yourself in the console:
    ```javascript
    function a() {
      console.log('a')
      return 0
    }

    function b() {
      console.log('b')
      return 2
    }

    a() || b() // prints both a and b
    b() || a() // prints only a
    a() && b() // prints only a
    b() && a() // prints both a and b
    ```
