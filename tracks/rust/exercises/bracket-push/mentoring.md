### Concepts

- stack or recursion
- `HashMap`s and `HashSet`s

### Reasonable solutions

A reasonable solution should do the following:

- Keep track of the associations between specific brackets using a `HashMap`, a closure, or something of the like. 
- Perform as few explicit checks for specific brackets as possible; instead, one possible strategy is to store openers and closers in separate `HashSet`s, and then check if the current char is contained in either set. 
- Return an expression that evaluates to a boolean instead of using an if-else. 

### Examples

This solution utilizes a `HashMap` to keep track of the associated pairs of brackets, and a `HashSet` to keep track of the closing brackets. 
```rust
use std::collections::{HashMap, HashSet};

pub fn brackets_are_balanced(string: &str) -> bool {
  let pairs: HashMap<_, _> = [('[', ']'), ('(', ')'), ('{', '}')]
    .iter()
    .cloned()
    .collect();
  let closers: HashSet<_> = pairs.values().cloned().collect();
  let mut stack: Vec<char> = vec![];

  for char in string.chars() {
    match pairs.get(&char) {
      // got back the closer associated with the char, so it was a valid opener
      Some(&closer) => {
        // add the closer to the stack
        stack.push(closer);
      },
      None => {
        if closers.contains(&char) {
          let expected = stack.pop();
          if expected != Some(char) { return false; }
        }
      }
    }
  }

  stack.is_empty()
}
```

This solution utilizes a `match` statement within a closure to keep track of the associated pairs of brackets.
```rust
pub fn brackets_are_balanced(string: &str) -> bool {
    let complement = |c| match c {
        '[' => ']',
        '{' => '}',
        '(' => ')',
        _ => unreachable!()
    };

    let mut expected: Vec<char> = vec![];

    for c in string.chars() {
        match c {
            '(' | '[' | '{' => expected.push(complement(c)),
            ')' | ']' | '}' => if expected.pop() != Some(c) {
                return false;
            },
            _ => {}
        }
    }

    expected.is_empty()
}
```

### Common Suggestions

- Suggest utilizing a `HashSet` or `HashMap` to hold opening and closing brackets for easy fetching in the situation that a submission manually checks for them. 
- A `HashSet` of opening brackets can be easily generated from a `HashMap` of bracket pairs with `pairs().keys().cloned().collect()`; likewise a `HashSet` of closing brackets can be easily generated with `pairs().values().cloned().collect()`. 
- Use a stack to facilitate the LIFO ordering of brackets needed to ascertain whether a string is balanced or not.
