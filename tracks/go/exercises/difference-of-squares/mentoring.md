# Difference of squares

The point of this exercise is to get the student to research the solution to the problem,
and introduce with them the idea that we do not need to reinvent the wheel every time we
write a new program; it is perfectly acceptable, and even encouraged in real life software engineering,
to find and implement existing solutions to common problems.

## Reasonable Solutions

```
package diffsquares

// SumOfSquares is the sum of the squares in range [1,n]
func SumOfSquares(n int) int {
	return n * (n + 1) * (2*n + 1) / 6
}

// SquareOfSum is the sum of numbers in range [1,n], squared
func SquareOfSum(n int) int {
	sum := n * (n + 1) / 2
	return sum * sum
}

// Difference is the difference betwee sum of squares and square of sums
func Difference(n int) int {
	return SquareOfSum(n) - SumOfSquares(n)
}
```

## Common suggestions

**Find the result of either function with a for loop**

- While the solution works, encourage the student to dig more and find the formulas that will allow the student to return the solutions with a one-liner.

**Different variable types for numeric values**

- Very often students will opt for executing simple math operations by leveraging the `math` package.  
  This normally means casting variables to `float64` and back, in order to use functions like `math.Pow()` to square the values.  
  We can explain that casting to different variable types has a cost, both in readability and in performance, and that it is generally frowned upon.
  The reason `math` package supports `float64` values exclusively is because operating with decimal points brings its own set of challenges, (which is true for any programming language) which are dealt with by the package itself.  
  For the sake of doing simple math operations, like squaring a number `n`, Go encourages programmers to write their own implementations, such as a simple `n * n`.

## Talking points

- Difference between execution in constant time (O(1)) and linear time (O(n)).
  Discussion should not veer the student into always finding the _best_ and most performant algorithm to solve problems (there are better platforms out there that promote such programming style);  
  in fact, we should also explain that readability should take precedence over performance. This exercise is however a good chance to introduce the student to such concepts as Big-O notation, if they weren't familiar with it before.

## Mentoring Tools

- [Exalysis](https://github.com/exercism/exalysis) is a tool designed to help mentors of the Exercism Go track. It will watch the clipboard for Exercism download links, automatically download the student's solution, run the tests, check e.g. `gofmt` and `golint`, and make several helpful suggestions for the student based on static analysis of the code for common errors and problems. The results are copied to the clipboard, so all you need to do is paste the response, review it, edit it to add your own remarks, and submit.
