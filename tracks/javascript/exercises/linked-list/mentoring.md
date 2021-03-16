# Mentoring

This exercise is supposed to have the student use `class` for data structures.

## Reasonable solutions
```javascript
class Node {
  constructor({ value, next, prev }) {
    this.value = value
    this.next = next
    this.prev = prev
  }
}

export class LinkedList {
  constructor() {
    this.head = null
    this.tail = null
  }

  clear() {
    this.head = null
    this.tail = null
  }

  push(value) {
    const element = new Node({ value, prev: this.tail })

    if (this.tail) {
      this.tail.next = element
    } else {
      this.head = element
    }

    this.tail = element
  }

  unshift(value) {
    const element = new Node({ value, next: this.head })

    if (this.head) {
      this.head.prev = element
    } else {
      this.tail = element
    }

    this.head = element
  }

  pop() {
    if (!this.tail) {
      throw new Error('list is empty')
    }

    const { value } = this.tail

    if (this.tail.prev) {
      this.tail = this.tail.prev
      this.tail.next = null
    } else {
      this.clear()
    }

    return value
  }

  shift() {
    if (!this.head) {
      throw new Error('list is empty')
    }

    const { value } = this.head

    if (this.head.next) {
      this.head = this.head.next
      this.head.prev = null
    } else {
      this.clear()
    }

    return value;
  }

  count() {
    let count = 0
    let element = this.head

    while (element) {
      count += 1
      element = element.next
    }

    return count
  }

  delete(value) {
    let element = this.head
    while (element) {
      if (element.value !== value) {
        element = element.next
        // eslint-disable-next-line no-continue
        continue
      }

      if (element.prev) {
        element.prev.next = element.next
      } else {
        this.head = this.head.next
      }

      if (element.next) {
        element.next.prev = element.prev
      } else {
        this.tail = this.tail.prev
      }

      break
    }
  }
}
```

Variations include the following
- A student may only pass `value` to `Node` and assign `prev` and `next` afterwards
- A student may forego the `throw` clauses completely as there are no test cases covering empty list popping and shifting.
- A student may actually put the logic on the `Node` class (classic linked list) and only have the `LinkedList` API keep track of `head` and `tail` (and fix them on mutations). In this case the `LinkedList` class is solely a proxy to the actual doubly linked-list.
- A student may traverse from `tail` backwards instead of `head` forwards.
- A student may use a `NO_ELEMENT` element instead of `null` or `undefined` to indicate there is no element at `next` / `head` / `prev` / `tail`.

### Note about Array solutions
The current tests are _not_ enforcing this implementation to actually be a
LinkedList, but the instructions clearly say you'll need to create a `Node` or
`Element` data structure pointing to `next` and `prev`. The following _could_ be
accepted but you should encourage the student to actually implement this as a
linked list:

```javascript
export class LinkedList extends Array { }

LinkedList.prototype.count = function() {
  return this.length;
}

LinkedList.prototype.delete = function(value) {
  const index = this.indexOf(value)
  if (index !== -1) {
    this.splice(index, 1)
  }
}
```

Variations on this include array destructuring in the implementation of `pop`,
`push` etc, or using a backing array inside the `LinkedList` class. See *common
suggestions* for more information.

### Note about earlier versions
Earlier version had a different `Readme.MD` that pointed to using a `Deque`.
This usually only confused students and has been removed.

### Common suggestions
- If a student uses a backing array or the likes, talk about performance, the upsides of actually using a linked-list, talk about linked lists being [classical data structures](https://en.wikipedia.org/wiki/Linked_data_structure) and it being a good exercise to implement them in the intended way.
- If a student implements `count` by keeping track of `size` (with increments and decrements), suggest them to think about list traversal instead. You don't need to block approval for this, as it turns `count` into `O(1)` which is not a bad thing.
