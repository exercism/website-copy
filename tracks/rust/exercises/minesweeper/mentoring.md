# Mentoring

## Concepts

- Iterators
- Iterator Methods
- &str
- char

## Reasonable Solutions

A reasonable solution should:

- Use iterator methods instead of slice indexing whenever possible
- Avoid unnecessary heap allocation
- Handle edge cases (first and last line / column) gracefully
- ***optional***: Boost readability by e.g. defining mine character (`'*'`) as a constant

## Examples

Slightly modified from [insideoutclub's solution](https://exercism.io/tracks/rust/exercises/minesweeper/solutions/08cd76e81c9443e8a0f8c3a4883cbb42):
```rust
use std::{char::from_digit, convert::TryFrom};

const MINE_BYTE: u8 = b'*';
const MINE_CHAR: char = '*';

pub fn annotate(minefield: &[&str]) -> Vec<String> {
    minefield
        .iter()
        .enumerate()
        .map(|(y, line)| {
            line.chars()
                .enumerate()
                .map(|(x, c)| match c {
                    MINE_CHAR => MINE_CHAR,
                    _ => match count_mines(minefield, x, y) {
                        0 => ' ',
                        x => from_digit(u32::try_from(x).unwrap(), 10).unwrap(),
                    },
                })
                .collect()
        })
        .collect()
}

fn count_mines(minefield: &[&str], x: usize, y: usize) -> usize {
    (y.saturating_sub(1)..=y + 1)
        .filter_map(|y| minefield.get(y))
        .flat_map(|line| (x.saturating_sub(1)..=x + 1).filter_map(move |x| line.as_bytes().get(x)))
        .filter(|&&c| c == MINE_BYTE)
        .count()
}
```
If they're handling edge cases with if blocks or rolling out their own implementation of `saturating_sub`:
```
Nice attempt handling the first line individually: subtracting 1 from the first row index, usize 0, will cause overflow. Good news is there's a method of usize in std for that purpose: 

[https://doc.rust-lang.org/std/primitive.usize.html#method.saturating_sub](https://doc.rust-lang.org/std/primitive.usize.html#method.saturating_sub)

in particular, 0usize.saturating_sub(1) == 0. With its help this if block may not be necessary.
```
An alternative approach to this exercise is to distribute mine counts from each mine to empty squares surrounding it. This approach requires more allocation (in safe Rust: with unsafe blocks bytes in a string can be manipulated by as_bytes_mut). It could be discouraged because of the extra allocation, in that case at least a concise explanation to its impact on performance (best with real-life examples you encountered) should be provided.
