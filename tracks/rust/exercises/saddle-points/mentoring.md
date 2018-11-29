# Saddle Points

## Concepts

- iterators
- vectors

## Reasonable solutions

A reasonable solution should do the following:

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

## Example Comments
