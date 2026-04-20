The tolerance (DOUBLE_EQUALITY_TOLERANCE) is too small for the unit test testRaiseARealNumberToAPositiveRationalNumber(). 
The calculation of exp() is too numerically sensitive to whether the user implements 
```
Math.pow(Math.pow(x, numerator), 1.0/denominator)
```
or
```
Math.pow(Math.pow(x, 1.0/denominator), numerator)
```
Both are mathematically equivalent, however, the first one fails the unit test whereas the second passes. 
Furthermore, the instructions to the exercise bias the user towards the first implementation.
