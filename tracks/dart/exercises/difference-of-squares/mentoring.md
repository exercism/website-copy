# Mentoring

## Reasonable solutions

We need to have two three methods:

- the first one is sqareOfSum that will return the sum of all numbers and squared afterwards
- the second method is the sumOfSquares which returns the sum of sqared numbers
- the last method - differenceOfSquares - returns the difference of both of the methods above

This exercise allows students to be tidy in coding their solution. Putting everything in methods that can be used in other methods is welcomed practice.

```dart
class DifferenceOfSquares {
  int squareOfSum(int n) => pow(List<int>.generate(n, (i) => i + 1).reduce((a,b) => a+b), 2);
  int sumOfSquares(int n) => List<int>.generate(n, (i) => pow(i+1, 2)).reduce((a,b) => a+b);
  int differenceOfSquares(int n) => squareOfSum(n) - sumOfSquares(n);
}
```


## Common suggestions

- they need to create three methods
- use [generate-method][reference-generate-method] to generate a List of incremented numbers
- [reduce-method][reference-reduce-method] sums the generated list 
- [pow-method][reference-pow-method] is a maths function to put x to the power of y

[reference-generate-method]: https://fluttermaster.com/how-to-use-list-generate-in-dart/
[reference-reduce-method]: https://api.dart.dev/stable/2.18.1/dart-core/Iterable/reduce.html
[reference-pow-method]: https://api.dart.dev/stable/2.10.5/dart-math/pow.html


## Solution Video

Step by step [video][youtube-video] guide solution for this exercise

[youtube-video]: https://www.youtube.com/watch?v=iwvcEKG_2qU
