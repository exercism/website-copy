# Mentoring

## Reasonable solutions

This exercise has many _valid_ implementations, but also many suggestions that
can be applied to implementations. This exercise is meant to be implemented
with as little of built in functions as possible. This means that a backing
array is allowed, but _no_ functions from the `Array.prototype` should be used.

Most students will actually still use a backing array for the values but have
various ways of not using the built in functions to process them. There are (at
least) two correct ways of implementing this using only array destructuring to
go from the test array to the internal representation and from the internal
representation back to `values`.

> *Note*: You don't need **any** function from the `Array.prototype`, and only
> need the language feature to build construct and desconstruct arrays via
> destructuring as well as the array literal `[]`.
>
> *Note*: most implementations using `for` loops, also use `.length` on the
> backing array, or the `array[indexer]`. You don't need either!

### Functional data type without backing array

This is a representation of one of the most fundamental *cons* tructs in most
functional languages called [`Cons`](https://en.wikipedia.org/wiki/Cons). It
is actually a way to build a linked-list.

```javascript
Cons.fromArray([1, 42, 'foo'])
// => Cons(1, Cons(42, Cons('foo', Null)))

Cons.fromArray()
// => Null

Cons(1, Cons(42, Cons('foo', Null))).values
// => [1, 42, 'foo']

Null.values
// => []
```

The `Null` object is a convenience object to replace `null` or `undefined` at
the end of the list and allows for code without a any branches (exception is
the conversion code).

```javascript
const Null = {
  get value() { return undefined },
  get next() { return this },
  get values() { return [] },

  get() { return this.value },
  push(item) { return new Cons(item, this) },
  length() { return 0 },
  append(other) { return other },
  concat() { return this },
  foldl(_, initial) { return initial },
  foldr(_, initial) { return initial },
  filter() { return Null },
  reverse() { return this },
  map() { return this },
}

class Cons {
  static fromArray([head, ...tail]) {
    if (head === undefined) {
      return Null
    }

    return new Cons(head, Cons.fromArray(tail || []))
  }

  constructor(value, next = Null) {
    this.value = value
    this.next = next
  }

  get values() {
    return [this.value, ...this.next.values]
  }

  get(i) {
    return i === 0
      ? this.value
      : this.next.get(i - 1)
  }

  push(item) {
    this.next = this.next.push(item)
    return this
  }

  length() {
    return 1 + this.next.length()
  }

  append(other) {
    return other.foldl((result, item) => result.push(item), this)
  }

  concat(others) {
    return others.foldl((result, other) => result.append(other), this)
  }

  foldl(callback, initial = undefined) {
    return this.next.foldl(callback, callback(initial, this.value))
  }

  foldr(callback, initial = undefined) {
    return callback(this.next.foldr(callback, initial), this.value)
  }

  filter(predicate) {
    return this.foldl(
      (result, item) => (predicate(item) && result.push(item)) || result,
      Null,
    )
  }

  map(expression) {
    return this.foldl(
      (result, item) => result.push(expression(item)),
      Null,
    )
  }

  reverse() {
    return this.next.reverse().push(this.value)
  }
}

export class List {
  constructor(values = []) {
    return Cons.fromArray(values)
  }
}
```

The `static fromArray` and `get values()` functions are the only functions
dealing with the outside datatype (`Array`). Everything else is implemented on
`Cons`.

`List` returns this `Cons` type from its constructor.

### Alternative using List with backing array

The `Cons` concept is **not** a necessity. If we take the same rules of only
using the language feature for constructing and destructing array, this can be
accomplished as follows:

```javascript
const fold = (collection, callback, initial = undefined) => {
  const [head, ...tail] = collection
  return head ? fold(tail, callback, callback(initial, head)) : initial
};

export class List {
  constructor(values = []) {
    this.values = values
  }

  foldl(reducer, initial = undefined) {
    return fold(this.values, reducer, initial)
  }

  push(item) {
    this.values = [...this.values, item]
    return this;
  }
}
```

All the other functions implementations are similar to the reasonable solution
above and use the same iteration concept:

```javascript
filter(predicate) {
  return this.foldl(
    (result, item) => (predicate(item) && filtered.push(item)) || result,
    new List()
  )
}

length() {
  return this.foldl(acc => acc + 1, 0);
}
```

It's important to note that in this implementation there are still no `for`
loops, no use of the `length` property, no `push` etc.

### A note about foreach

There is no `forEach` in this solution, because it's not mandated by the tests.
If a student uses `forEach` to iterate, instead of `foldl`, that's okay. If a
student just added `forEach` for posterity, that's fine too.

### Common suggestions

The basis of all suggestions is function re-use. `foldl` is the basic
building block that can be used for all the other functions. If a student has
multiple `loops` and/or duplication, this is where to start with cleaning up
their solution.

Solutions mutating `values` directly in _each_ function (e.g. concat not using
functions defined on `List` but using `foreEach` plus
`values = [...values, ...list.values]`) are usually tied to a backing array, or
should have abstracted this construction away into a `push` and `unshift`.

- Implement `append` using `foldl`:
  ```javascript
  append(other) {
    return other.foldl((result, item) => result.push(item), this)
  }

  // immutable + destructuring
  append(other) {
    return new List([ ...this.values, ...newList.values ])
  }
  ```

- Implement `concat` using `foldl`. Students sometimes have branches here, but
  there's no need for any:
  ```javascript
  concat(others) {
    return others.foldl((result, other) => result.append(other), this)
  }
  ```

- Implement length using `foldl`. Students sometimes use an internal backing
  array property, but should use the equivalent of "count" in most functional
  languages. Discourage a for loop (because it requires `backingarray.length`):
  ```javascript
  length() {
    return this.foldl(length => length + 1, 0)
  }
  ```

- Implement `forEach` using `foldl`. Students sometimes use an internal backing
  array property, but should use the equivalent of "count" in most functional
  languages. Discourage a for loop (because it requires `backingarray.length`):
  ```javascript
  forEach(callback) {
    this.foldl((_, item) => callback(item))
  }
  ```

- Implement `foldr` using `reverse` OR `reverse` using `foldr` OR `foldl` OR
  `foldr` using `foldl`. Students often use a swapping algorithm here, but that
  uses the `backingarray[indexer]`. Encourage using a reverse `push` (`unshift`)
  or reverse destructuring `([...heads, tail])`, or `foldl`:
  ```javascript
  // foldr using foldl (Cons implementation)
  foldr(callback, initial = undefined) {
    return callback(this.next.foldr(callback, initial), this.value)
  }

  // reverse using foldl
  reverse() {
    return this.foldl((result, item) => new List([item, result.values]), this)
  }

  // reverse using unshift
  unshift(item) {
    this.values = [item, ...this.values]
    return this
  }

  reverse() {
    return this.foldl((result, item) => result.unshift(item), new List())
  }
  ```

- Implement `map` using `foldl`. Students sometimes use an internal
  backing array property, but should use the equivalent of map in most
  functional languages. Discourage a for loop (because it requires
  `backingarray.length`):
  ```javascript
  map(mapper) {
    return this.foldl((result, item) => result.push(), new List())
  }
  ```

- Implement `filter` using `foldl`. Students sometimes use an
  internal backing array property, but should use the equivalent of select in
  most functional languages. Discourage a for loop (because it requires
  `backingarray.length`):
  ```javascript
  filter(predicate) {
    return this.foldl(
      (result, item) => (predicate(item) && result.push(item)) || result,
      new List()
    )
  }
  ```

### Talking Points

- Mutability / Immutability
- Iteration without knowing _when_ it ends until it ends / without a `for`
  loop (`Cons` with `Null`, this is how `Iterators` work: `while(hasNext())`)
- Internal structures pros and cons (`Array` vs Linked List vs ...).
