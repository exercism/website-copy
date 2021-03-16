# Mentoring

### Concepts

- Iterating over strings with [`chars`](https://doc.rust-lang.org/std/primitive.str.html#method.chars)
- Sorting string chars
- [`filter`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.filter)

### Reasonable solutions

A reasonable solution should:

- Use [`chars`](https://doc.rust-lang.org/std/primitive.str.html#method.chars) to iterate over characters in a string
- Sort the chars of a string with [`sort`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.sort)
- Use [`filter`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.filter) to find the strings that satisfy the criteria
- Use [`to_lowercase`](https://doc.rust-lang.org/std/primitive.char.html#method.to_lowercase) or [`to_uppercase`](https://doc.rust-lang.org/std/primitive.char.html#method.to_uppercase) to normalize the input strings

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

#### Student's Solution Initializes a `HashMap` For Every Possible Anagram

Your response to this depends on whether you feel this is overkill or not. Certainly the runtime will be more efficient than sorting every possible anagram instead, but on the other hand, sorting every possible anagram incurs a rather minimal runtime hit at the cost of a pretty significant memory saving. Ultimately, there can be an argument made for either side, though there seems to be a slight preference amongst more seasoned mentors for the lower memory overhead option. 

#### Lifetime explanation

The student may ask for an explanation of lifetime annotations.
```markdown
A HashSet of str references is being returned. They can't be references to str values created in `anagrams_for`, since those values would go out of scope and be destroyed at the end of the `anagrams_for` function. So they need to reference something being passed in. The HashSet is populated by references to the values in `possible_anagrams`, so we have to specify to the compiler that we are sure that the lifetime of the values referenced in the return HashSet is as long as for the values referenced in `possible_anagrams.`

The common idiom of using `'a` doesn't really help to understand. This might make it clearer...
```
```rust
pub fn anagrams_for<'possible_anagrams_lifetime>(word: &str, possible_anagrams: &[&'possible_anagrams_lifetime str]) -> HashSet<&'possible_anagrams_lifetime str> {
```
```markdown
It's way more verbose, which is why it's not done, but it may help to make it clearer what we're telling the compiler. If we were not passing in `word: &str` then [`lifetime elision`] would allow us to omit all of the specified lifetimes, as we then wouldn't have to tell the compiler if the output referenced `word` or `possible_anagrams`.

Of course, we can't return `HashSet<str>` because, as the compiler tells us, it can't determine the length of the str at compile time.

So, another way to do this would be return a heap-allocated object whose size of its pointer on the stack is known. This won't be accepted by the tests, but in the world one could do...
```
```rust
pub fn anagrams_for(word: &str, possible_anagrams: &[&str]) -> HashSet<String> {
...
anagrams.insert(possibility.to_string());
```
```markdown
For just a few values it's not a big deal, but if we were dealing with a lot of values we would want the performance of keeping them references and leading the compiler by the hand by the lifetime annotations.

You might be interested in a [`detailed description of lifetimes`]. It's somewhat long and it takes a while before it starts getting very interesting, but by the end you may think it's been worth the time reading it.

[`lifetime elision`]: https://doc.rust-lang.org/reference/lifetime-elision.html
[`detailed description of lifetimes`]: https://fasterthanli.me/articles/i-am-a-java-csharp-c-or-cplusplus-dev-time-to-do-some-rust

```
