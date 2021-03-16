# Mentoring

### Concepts

- iterators
- vectors

### Reasonable solutions

A reasonable solution should do the following:

- Avoid unnecessary allocations. This is a good exercise to go over how vectors
  are heap allocated and how constructing and using them has runtime costs.
  For most exercises its a good idea to avoid worrying about performance and
  optimization but this one is an exception.
- An effective solution should only utilize one, or possibly two vectors. A one
  vector solution would calculate the max value of the row once for each row,
  and would calculate the max value of a column each time the current column is
  equal to the max value of the row. This can cause re calculations of the same
  column min, which would have negative performance implications on larger
  matrixes. Adding a second vector to store or cache the mins of columns is
  fine.

### Examples

```rust
pub fn find_saddle_points(input: &[Vec<u64>]) -> Vec<(usize, usize)> {
    let mut mins: Vec<Option<u64>> = vec![None; input[0].len()];
    let mut min = |colnum: usize| {
        *mins[colnum].get_or_insert_with(|| input.iter().map(|row| row[colnum]).min().unwrap())
    };

    let mut results = vec![];

    for (rownum, row) in input.iter().enumerate() {
        let rowmax = row.iter().max();
        for (colnum, &val) in row.iter().enumerate() {
            if val == *rowmax.unwrap() && val == min(colnum) {
                results.push((rownum, colnum));
            }
        }
    }

    results
}
```
