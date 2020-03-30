### Concepts

- Iterating over strings with [`chars`](https://doc.rust-lang.org/std/primitive.str.html#method.chars)
- Sorting string chars
- [`filter`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.filter)

### Reasonable solutions

A reasonable solution should:

- Use [`chars`](https://doc.rust-lang.org/std/primitive.str.html#method.chars) to iterate over characters in a string
- Sort the chars of a string with [`sort`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.sort)
- Use [`filter`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.filter) to find the strings that satisfy the criteria

### Examples

```rust
use std::collections::HashSet;

fn sort(word: &str) -> String {
    let mut sorted: Vec<char> = word.chars().collect();
    sorted.sort();
    sorted.into_iter().collect()
}

pub fn anagrams_for<'a>(word: &str, inputs: &[&'a str]) -> HashSet<&'a str> {
    let lower = word.to_lowercase();
    let sorted = sort(&lower);
    inputs
        .iter()
        .filter(|input| {
            let input_lower = input.to_lowercase();
            lower != input_lower && sorted == sort(&input_lower)
        })
        .cloned()
        .collect()
}
```

### Common Suggestions

#### Student's Solution Uses the Itertools and/or Unicode Segmentation Crate

This is fine, so long as the student's solution touches upon the concepts listed. You can always challenge the student to go further with their implementation and submit a solution that doesn't use the `itertools` crate. 
