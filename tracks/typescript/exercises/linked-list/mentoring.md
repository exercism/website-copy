# Mentoring

### Reasonable solutions
```typescript
interface NodeParams<T> {
  value: Readonly<T>
  next?: Readonly<Node<T>>
  prev?: Readonly<Node<T>>
}

class Node<T> {
  public readonly value: T
  public next: Node<T> | undefined
  public prev: Node<T> | undefined

  constructor({ value, next, prev }: NodeParams<T>) {
    this.value = value
    this.next = next
    this.prev = prev
  }
}

export default class LinkedList<T> {
  private head: Node<T> | undefined
  private tail: Node<T> | undefined

  constructor() {
    this.head = undefined
    this.tail = undefined
  }

  clear(): LinkedList<T> {
    this.head = undefined
    this.tail = undefined
    return this
  }

  push(value: Readonly<T>): LinkedList<T> {
    const element = new Node({ value, next: this.head })

    if (this.head) {
      this.head.prev = element
    } else {
      this.tail = element
    }

    this.head = element
    return this
  }

  unshift(value: Readonly<T>): LinkedList<T> {
    const element = new Node({ value, prev: this.tail })

    if (this.tail) {
      this.tail.next = element
    } else {
      this.head = element
    }

    this.tail = element
    return this
  }

  pop(): T {
    if (!this.head) {
      throw new Error('list is empty')
    }

    const { value } = this.head

    if (this.head.next) {
      this.head = this.head.next
      this.head.prev = undefined
    } else {
      this.clear()
    }

    return value
  }

  shift(): T {
    if (!this.tail) {
      throw new Error('list is empty')
    }

    const { value } = this.tail

    if (this.tail.prev) {
      this.tail = this.tail.prev
      this.tail.next = undefined
    } else {
      this.clear()
    }

    return value
  }

  count(): number {
    let count = 0
    let element = this.head

    while (element) {
      count += 1
      element = element.next
    }

    return count
  }

  delete(value: Readonly<T>): LinkedList<T> {
    let element = this.head
    while (element) {
      if (element.value !== value) {
        element = element.next
        continue
      }

      if (element.next) {
        element.next.prev = element.prev
      } else {
        this.tail = this.tail!!.prev
      }

      if (element.prev) {
        element.prev.next = element.next
      } else {
        this.head = this.head!!.next
      }

      break
    }

    return this
  }
}
```


Variations include the following:
- A student may only pass `value` to `Node` and assign `prev` and `next` afterwards
- A student may forego the `throw` clauses completely as there are no test cases covering empty list popping and shifting.
- A student may actually put the logic on the `Node` class (classic linked list) and only have the `LinkedList` API keep track of `head` and `tail` (and fix them on mutations). `LinkedList` is than a mere proxy to the actual doubly linked-list.
- A student may traverse from `tail` backwards instead of `head` forwards.
- A student may use a `NO_ELEMENT` element instead of `null` or `undefined` to indicate there is no element at `next` / `head` / `prev` / `tail`.
- A student does not need to `return this`.

#### Note about Array solutions
The current tests are _not_ enforcing this implementation to actually be a
LinkedList, but the instructions clearly say you'll need to create a `Node` or
`Element` data structure pointing to `next` and `prev`. The following _could_ be
accepted but you should encourage the student to actually implement this as a
linked list:

```typescript
export class LinkedList<T> extends Array<T> {
  count() {
    return this.length
  }

  delete(value: T) {
    const index = this.indexOf(value)
    if (index !== -1) {
      this.splice(index, 1)
    }
  }
}
```

Variations on this include array destructuring in the implementation of `pop`,
`push` etc, or using a backing array inside the `LinkedList` class. See *common
suggestions* for more information.

### Common suggestions
- If a student uses a backing array or the likes, talk about performance and the upsides of actually using a linked-list.
- If a student implements `count` by keeping track of `size` (with increments and decrements), suggest them to think about list traversal instead. You don't need to block approval for this, as it turns `count` into `O(1)` which is not a bad thing.

### Talking points
- If an input argument is not modified, mark it with `Readonly`
- The `value` of `Node` can be and should be `readonly`
- Instead of using `undefined` as an indicator that there is no element at `next` / `head` / `prev` / `tail`, a `NO_ELEMENT` constant could be used
