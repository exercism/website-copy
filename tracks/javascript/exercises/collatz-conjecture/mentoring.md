# Mentoring

## Reasonable solution

The collatz conjecture has multiple approaches when it comes to implementation,
both a recursive and an iterative implementation can be idiomatic.

### Recursive solution

The recursive approach is most natural one, given the description, which hints
at calling the same steps over and over, with different input, until the value
one is reached. A recursive solution should **not** have a bookkeeping variable
such as keeping track of how many times it has been called; instead each `step`
call increases the `return` value by one:

```javascript
export const steps = (n) => {
  if (n < 1) {
    throw new Error('Only positive numbers are allowed')
  }

  if (n === 1) {
    return 0
  }

  const next = n % 2 === 0
    ? n / 2
    : 3 * n + 1

  return 1 + steps(next)
}
```

Branching can also be accomplished by using a `switch` statement with
expressions:

```javascript
export const steps = (n) => {
  switch (true) {
    case n < 1: {
      throw new Error('Only positive numbers are allowed')
    }

    case n === 1: {
      return 0
    }

    case n % 2 === 0: {
      return 1 + steps(n / 2)
    }

    default: {
      return 1 + steps(3 * n + 1)
    }
  }
}
```

### Iterative solution

The iterative solution does require a _bookkeeping_ variable. The approach is
very similar to the recursive solution, and determining the next `n` can be
done the same ways (`if-else`, `switch` or `ternary`).

```javascript
export const steps = (n) => {
  if (n < 1) {
    throw new Error('Only positive numbers are allowed')
  }

  let count = 0

  while (n > 1) {
    n = n % 2 === 0
      ? n / 2
      :  3 * n + 1

    count += 1
  }

  return count
}
```

### Common suggestions

- The recursive approach must NOT have a bookkeeping variable
- Discourage `while(true)`, because we know that the number can never become
  _negative_, so having the while-expression check the value is preferable.
