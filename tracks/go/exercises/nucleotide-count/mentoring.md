# Nucleotide Count

### Reasonable Solutions

Using a map is probably the most idiomatic solution to this problem, especially since the Histogram type basically must be a map.
Using a switch is about four times faster over the provided test cases because it does not require hashing.

#### Map Example
```Go
// Package dna counts nucleotides
package dna

import "errors"

// Histogram is a mapping from nucleotide to its count in given DNA.
type Histogram map[rune]int

// DNA is a list of nucleotides.
type DNA string

// Counts generates a histogram of valid nucleotides in the given DNA.
// Returns an error if d contains an invalid nucleotide.
func (d DNA) Counts() (Histogram, error) {
	h := Histogram{
		'A': 0,
		'C': 0,
		'G': 0,
		'T': 0,
	}
	for _, r := range d {
		if _, ok := h[r]; !ok {
			return nil, errors.New("invalid nucleotide")
		}
		h[r]++
	}
	return h, nil
}
```

#### Switch Example
```Go
// Package dna counts nucleotides
package dna

import "errors"

// Histogram is a mapping from nucleotide to its count in given DNA.
type Histogram map[rune]int

// DNA is a list of nucleotides.
type DNA string

// Nucleotide indexes for counting
const (
	A = iota
	C
	G
	T
)

// ErrInvalidNucleotide is returned when it encounters something other than A/C/G/T
var ErrInvalidNucleotide = errors.New("invalid nucleotide")

// Counts generates a histogram of valid nucleotides in the given DNA.
// Returns an error if d contains an invalid nucleotide.
func (d DNA) Counts() (Histogram, error) {
	counts := [4]int{}
	for _, nucleotide := range d {
		switch nucleotide {
		case 'A':
			counts[A]++
		case 'C':
			counts[C]++
		case 'G':
			counts[G]++
		case 'T':
			counts[T]++
		default:
			return nil, ErrInvalidNucleotide
		}
	}
	return Histogram{
		'A': counts[A],
		'C': counts[C],
		'G': counts[G],
		'T': counts[T],
	}, nil
}
```

### Common Suggestions
- When you have a type definition for the Histogram, you can use it like the underlying type. For instance, you can `make(Histogram, 4)` or instantiate a literal `Histogram{...}`.
- If you know exactly how many elements will be in a map, it makes sense to set the capacity.
- Using numeric literals (e.g. `65` for A) throughout the code to represent letters is **not** reasonable. Instead, use rune literals (e.g. `'A'`), rune literals cast to bytes (e.g. `byte('A')`), or define constants (e.g. `const A = byte('A')`). All of these can be handled at compile time and will not impact runtime performance.
- `case 'A', 'C', 'G', 'T':` is more readable than `if r == 'A' || r == 'C' ...`.

### Talking Points
- Maps are useful for a variety of problems, and are idiomatic even when they may be slower for small data sets.
- [Optimize for clarity](https://google.github.io/styleguide/go/guide#style-principles) over performance until you need better performance. Performance optimizations should be guided by benchmarking and/or profiling. Writing "clever" code is discouraged for most Go code.
