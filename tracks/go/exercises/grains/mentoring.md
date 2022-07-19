# Grains

_Grains_

## Reasonable Solutions

This can be solved by calculating `2^n` (e.g. with `math.Pow`) or by using the shift operator `<<`. This solution uses the shift operator:

```
package grains

import (
	"fmt"
)

// Square returns the number of grains on a square on a chess board where the
// first square has 1 and every subsequent square doubles the number.
func Square(number int) (uint64, error) {
	if number < 1 || number > 64 {
		return 0, fmt.Errorf("input should be between 1 and 64 (inclusive), got: %d", number)
	}
	// a left shift is equivalent to multiplying by 2.  So we need to left
	// shift by num-1 times to get the number of grains on that square
	return 1 << (uint16(number) - 1), nil
}

// Total returns the total number of grains on the chess board
func Total() uint64 {
	// the number of grains added up to any point on the board is simply
	// two to the power of that number - 1 (because maths)
	return (1 << 64) - 1
}
```

## Common suggestions

In the exercise a `uint64` is used. Normally the `func Total()` should sum up the values from <code>2<sup>0</sup></code> to <code>2<sup>63</sup></code>:
```
func Total() uint64 {
	var total uint64 = 0
	for i := 0; i <= 63; i++ {
		total += uint64(math.Pow(float64(2), float64(i)))
	}
	return total
}
```
This results in `18446744073709551615` which is in binary `1111111111111111111111111111111111111111111111111111111111111111`. This is the max value a `uint64` can store, so when adding more values, an integer overflow is the result.

When using the following code, which counts to <code>2<sup>65</sup></code>, an integer overflow is the result:
```
func Total() uint64 {
	var total uint64 = 0
	for i := 0; i <= 65; i++ {
		total += uint64(math.Pow(float64(2), float64(i)))
	}
	return total
}
```

```
2^62=4611686018427387904     new sum: 9223372036854775807
2^63=9223372036854775808     new sum: 18446744073709551615
2^64=9223372036854775808     new sum: 9223372036854775807  <-- overflow
2^65=9223372036854775808     new sum: 18446744073709551615
```

Please watch out, there can be wrong implementations here that pass all the tests. As you can see, the result for after summing up to <code>2<sup>63</sup></code> and after summing uo to <code>2<sup>65</sup></code> is the same&rarr;all test-cases pass, also if the values are summed up to <code>2<sup>65</sup></code>.


## Talking points

## Mentoring Tools

* [Exalysis](https://github.com/exercism/exalysis) is a tool designed to help mentors of the Exercism Go track. It will watch the clipboard for Exercism download links, automatically download the student's solution, run the tests, check e.g. `gofmt` and `golint`, and make several helpful suggestions for the student based on static analysis of the code for common errors and problems. The results are copied to the clipboard, so all you need to do is paste the response, review it, edit it to add your own remarks, and submit.
