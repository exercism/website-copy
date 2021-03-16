# Mentoring

## Reasonable Solutions


Simple solution:

```java
public class DifferenceOfSquaresCalculator {

    int computeSquareOfSumTo(int number) {
        int result = 0;
        for (int i = 1; i <= number; i++) {
            result += i;
        }
        return (int)Math.pow(result, 2);
    }

    int computeSumOfSquaresTo(int number) {
        int result = 0;
        for (int i = 1; i <= number; i++) {
            result += Math.pow(i, 2);
        }
        return result;
    }

    int computeDifferenceOfSquares(int number) {
        return computeSquareOfSumTo(number) - computeSumOfSquaresTo(number);
    }
}
```

Simple solution (single iteration):
```java
public class DifferenceOfSquaresCalculator {
    int square(n) {
        return n * n;
    }

    int computeDifferenceOfSquares(int number) {
        int sum = 0;
        int sumOfSquares = 0;
        for (int i = 1; i <= number; i++) {
            sum += i;
            sumOfSquares += square(i);
        }
        return square(sum) - sumOfSquares;
    }
}
```

Functional solution:

```java
import static java.lang.Math.pow;
import static java.util.stream.IntStream.rangeClosed;

class DifferenceOfSquaresCalculator {

   int computeSquareOfSumTo(int input) {
      return square(rangeClosed(1, input).sum());
   }

   int computeSumOfSquaresTo(int input) {
      return rangeClosed(1, input).map(this::square).sum();
   }

   int computeDifferenceOfSquares(int input) {
      return computeSquareOfSumTo(input) - computeSumOfSquaresTo(input);
   }

   private int square(int input) {
      return (int) pow(input, 2);
   }
}
```

Solution based on the closed-form formula:

```java
import java.util.stream.IntStream;

public final class DifferenceOfSquaresCalculator {

    public int computeSquareOfSumTo(int n) {
        int temp = n * (n + 1) / 2;
        return temp * temp;
    }
    
    public int computeSumOfSquaresTo(int n) {
        return n * (n + 1) * (2 * n + 1) / 6;
    }
    
    public int computeDifferenceOfSquares(int n) {
        return computeSquareOfSumTo(n) - computeSumOfSquaresTo(n);
    }
}
```


## Common suggestions
* Creating a function like `square(int input)` makes life slightly easier
* Pointers to the closed-form formula can be found here: https://brilliant.org/wiki/sum-of-n-n2-or-n3/
