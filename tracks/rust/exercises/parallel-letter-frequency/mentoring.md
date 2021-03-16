# Mentoring

### Concepts

- Char and string manipulation
- Multithreading and synchronization toolkit in libstd
- Lifetime constraints, Send and Sync auto traits
- How the captured references determine the lifetime of a closure
- (optional) third party parallel crates

### Reasonable solutions

A reasonable solution should:

- Constrain the number of threads spawned according to worker_count
- Split work loads evenly among threads
- Surpass the performance of sequential implementation on at least one benchmark case
- Not use unsafe blocks to circumvent lifetime constraints naively
- ***Optional***: avoid spawning threads for extremely small work loads
- ***Optional***: avoid allocations with scoped threads or high level abstractions provided by third party crates

### Examples:

With libstd only (based on the solution by jguinart):
```rust
use std::collections::HashMap;
use std::thread;

fn count_letters<S: AsRef<str>>(lines: &[S]) -> HashMap<char, usize> {
    let mut result = HashMap::new();

    lines.iter().for_each(|l| {
        l.as_ref()
            .chars()
            .flat_map(|c| c.to_lowercase())
            .filter(|c| c.is_alphabetic())
            .for_each(|c| *result.entry(c).or_default() += 1);
    });

    result
}

const MIN_LOAD_SIZE: usize = 5;

pub fn frequency(input: &[&str], worker_count: usize) -> HashMap<char, usize> {
    let chunk_size = input.len() / worker_count + 1;
    if chunk_size < MIN_LOAD_SIZE {
        return count_letters(input);
    }

    let workers = input
        .chunks(chunk_size)
        .map(|chunk| {
            let lines = chunk.iter().map(|s| s.to_string()).collect::<Vec<_>>();
            thread::spawn(move || count_letters(&lines))
        })
        .collect::<Vec<_>>();

    let mut result = HashMap::new();
    for worker in workers {
        merge(&mut result, &worker.join().unwrap());
    }

    result
}

fn merge(result: &mut HashMap<char, usize>, freq: &HashMap<char, usize>) {
    freq
        .iter()
        .for_each(|(&k, &v)| *result.entry(k).or_default() += v);
}

// reference benchmark result
// running 6 tests
// test bench_large_parallel   ... bench:     834,037 ns/iter (+/- 51,419)
// test bench_large_sequential ... bench:   1,317,008 ns/iter (+/- 51,184)
// test bench_small_parallel   ... bench:     240,675 ns/iter (+/- 16,908)
// test bench_small_sequential ... bench:      44,837 ns/iter (+/- 1,896)
// test bench_tiny_parallel    ... bench:         207 ns/iter (+/- 8)
// test bench_tiny_sequential  ... bench:         162 ns/iter (+/- 9)
```
With scoped threads provided by crossbeam:
```rust
use crossbeam_utils::thread;
use std::collections::HashMap;

type Frequencies = HashMap<char, usize>;

fn collect_chars(slice: &[&str]) -> Frequencies {
    let mut map = HashMap::new();
    slice
        .iter()
        .flat_map(|s| s.chars())
        .flat_map(|c| c.to_lowercase())
        .filter(|c| c.is_alphabetic())
        .for_each(|c| {
            *map.entry(c).or_default() += 1;
        });
    map
}

fn append_chars(this: &mut Frequencies, other: &Frequencies) {
    for (&c, count) in other.iter() {
        *this.entry(c).or_insert(0) += count;
    }
}

const MIN_LOAD_SIZE: usize = 5;

pub fn frequency(input: &[&str], worker_count: usize) -> HashMap<char, usize> {
    let load_size = input.len() / worker_count + 1;

    if load_size < MIN_LOAD_SIZE {
        return collect_chars(input);
    }

    thread::scope(|scope| {
        let handles = input
            .chunks(load_size)
            .map(|work_load| scope.spawn(move |_| collect_chars(work_load)))
            .collect::<Vec<_>>();

        handles
            .into_iter()
            .fold(Frequencies::new(), |mut acc, handle| {
                append_chars(&mut acc, &handle.join().unwrap());
                acc
            })
    })
    .unwrap()
}

// reference benchmark result
// running 6 tests
// test bench_large_parallel   ... bench:     718,435 ns/iter (+/- 11,169)
// test bench_large_sequential ... bench:   1,256,775 ns/iter (+/- 39,374)
// test bench_small_parallel   ... bench:     232,211 ns/iter (+/- 3,215)
// test bench_small_sequential ... bench:      43,885 ns/iter (+/- 3,951)
// test bench_tiny_parallel    ... bench:         175 ns/iter (+/- 12)
// test bench_tiny_sequential  ... bench:         165 ns/iter (+/- 10)
```
With high level abstraction in rayon:
```rust
use rayon::prelude::*;
use std::collections::HashMap;

type Frequencies = HashMap<char, usize>;

fn collect_chars(slice: &[&str]) -> Frequencies {
    let mut map = HashMap::new();
    slice.iter()
        .flat_map(|s| s.chars())
        .flat_map(|c| c.to_lowercase())
        .filter(|c| c.is_alphabetic())
        .for_each(|c| {
            *map.entry(c).or_default() += 1;
        });
    map
}

fn append_chars(this: &mut Frequencies, other: &Frequencies) {
    for (&c, count) in other.iter() {
        *this.entry(c).or_insert(0) += count;
    }
}

pub fn frequency(input: &[&str], worker_count: usize) -> HashMap<char, usize> {
    let work_load = input.len() / worker_count + 1;

    // otherwise rayon cheats by spawning global thread pool beforehand
    let pool = rayon::ThreadPoolBuilder::new()
        .num_threads(worker_count)
        .build().unwrap();

    pool.install(|| {
        input
            .par_chunks(work_load)
            .map(|s| collect_chars(s))
            .reduce(HashMap::new, |mut acc, map| {
                append_chars(&mut acc, &map);
                acc
            })
    })
}

// reference benchmark results
// running 6 tests
// test bench_large_parallel   ... bench:     693,635 ns/iter (+/- 11,275)
// test bench_large_sequential ... bench:   1,272,481 ns/iter (+/- 26,080)
// test bench_small_parallel   ... bench:     192,525 ns/iter (+/- 4,335)
// test bench_small_sequential ... bench:      44,306 ns/iter (+/- 3,133)
// test bench_tiny_parallel    ... bench:     149,884 ns/iter (+/- 9,356)
// test bench_tiny_sequential  ... bench:         164 ns/iter (+/- 4)
```

Thanks to the type system of Rust, if the solution compiles & passes all the tests, usually there's no data race in it. Students may however question the necessity of these apparently too restrictive constraints, and it's the mentors' responsibility to explain these concepts throughout:

- Why std::thread::spawn requires all captured variables having 'static lifetime: thread in libstd is unscoped, they can live for arbitrarily long & outlive all lifetimes except 'static. It may be helpful to provide an historical note on scoped thread in pre-1.0 Rust and why it's removed: https://github.com/rust-lang/rust/issues/24292. An introduction to scoped thread in external crates (rayon or crossbeam) may also be helpful. 
- What is Send and why std::thread::spawn requires all captured variables implement Send: for students who have gotten this far into the Rust track it's probably enough to direct them to the documentation of [std::sync::Arc](https://doc.rust-lang.org/std/sync/struct.Arc.html). Nomicon also has [a chapter explaining data race](https://doc.rust-lang.org/nomicon/races.html).

If they use channels to send the results out from the spawned threads:
```
The channels sending values back to the main thread is kind of unnecessary since the spawned thread can return a value on exit and be recovered later by JoinHandle::join.
```

A subtle detail is the characters must be filtered after being cast to lowercase, otherwise the letter frequency may contain non-alphabetic characters. e.g. the unicode character \u{0130}, [capital I with dot above](https://unicode.org/cldr/utility/character.jsp?a=0130&B1=Show), is itself alphabetic, but yields two characters when cast to lowercase, one of them (\u{0307}, [combining dot above](https://unicode.org/cldr/utility/character.jsp?a=0307&B1=Show)) is not alphabetic.
