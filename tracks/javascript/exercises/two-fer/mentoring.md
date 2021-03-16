# Mentoring

The point of this exercise is to get them going after the "hello-world"
exercise, create a file (by checking the test) and figuring out how to work the
`.spec` files. It's supposed to teach students:

- [`default values` for parameters][ref-default-parameter]
- [`template literals`][ref-template-literal].

### Reasonable Solutions

There is only one reasonable form of solution, where the method of exporting or
defining the function can be different.

#### Arrow function expression

```javascript
export const twoFer = (name = 'you') => `One for ${name}, one for me.`
```

#### Function declaration

```javascript
export function twoFer(name = 'you') {
  return `One for ${name}, one for me.`
}
```

#### Approvability

You should **_only approve_** this if it matches the solutions above, with a few
exceptions where you may be lenient:

- a student uses CommonJS style `exports`.
- a student does not inline the `export`

In all these cases, suggest they make a change (inline the `return`, use a
default value for the parameter, use ES6 style exports respectively), approve
the submission and tell the student they can move on or improve:

  I'm approving your current submission so you can continue down the track, but
  feel free to iterate, improve and submit another solution. I will continue to
  mentor your future iterations.

### Common suggestions

This is the first mentored exercise, so you may use this to determine a
student's skill, help them set up their test suite, and generally point out
certain things. In the JavaScript track, this exercise is not meant to be a
barrier so in general, don't be harsh but set the tone for the rest of the
mentored track.

Here is a template you can copy with a few example comments. The goal of this
exercise is to have them remove any conditional _and_ use a template literal.

    Hi there {name},

    Congrats on submitting your first exercise for the JavaScript
    track. I have a few comments for you:

    - In Javascript, the result of an expression can be returned!
      ```javascript
      let result
      if (name === undefined) {
        result = 'One for you, one for me.'
      } else {
        result = `One for ${name}, one for me.`
      }
      return result
      ```
      Given the example above, you can rewrite this to:
      ```javascript
      if (name === undefined) {
        return 'One for you, one for me.'
      }
      return `One for ${name}, one for me.`
      ```
    - Have you considered using a [default value](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Default_parameters)   for the parameter `name`? That way you don't need a conditional at all!

#### Literal instead of dynamic return

This applies if a student has one of the following:

- `if (parameter === 'Alice')`
- `if (parameter === 'Bob')`

In each case, they have a _shameless green_ solution, meaning that it passes the
test, but not the _intent_. In this case explain that Alice and Bob are
examples, but the function should work with _any_ name.

#### Conditionals

This applies if a student has one of the following:

- `if (expression)`
- `expression ? consequent : alternate`
- `literal || 'you'`

In each case, they're handling the fact that sometimes a name is not passed in.
Suggest they use a [default value][ref-default-parameter] for the parameter
(usually called `name`).

#### String concatenation

This applies if a student does _not_ use a [template literal][ref-template-literal]:

- `'One for ' + name + ', one for me'`

This is the perfect time to point them towards templated string literals and how
to interpolate values.

#### CommonJS exports

This applies if the student does _not_ use ES6 style exports:

- `module.exports = { twoFer }`

Explain that we use babel, and this allows the student to use all new language
features. They may use ES6 style `export` as well as any other ES6 feature. If
this is the **only** comment, approve but give this suggestion for future
exercises.

### Talking points

- The difference of intent between a default value and using a falsy logical or
  (`name || 'you'`). What happens when the input is `null`, what happens when
  the input is `''`, what happens when the input is ... `0`?
- On exercism there is no need for [defensive programming][ref-defensive-programming].
  This means they should not test if the input is a string, or something else
  unforeseen. The test cases should indicate what a function might be called
  with.

[ref-template-literal]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals
[ref-default-parameter]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Default_parameters
[ref-defensive-programming]: https://en.wikipedia.org/wiki/Defensive_programming
