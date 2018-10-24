### Reasonable Solutions

Functional solution:

```kotlin
class Squares(val number: Int) {
    fun squareOfSum(): Int = (1..number).sum().square()

    fun sumOfSquares(): Int = (1..number).sumBy { it.square() }

    fun difference(): Int = squareOfSum() - sumOfSquares()

    private fun Int.square(): Int = this * this
}
```

Or solution based on the closed-form formula:

```kotlin
class Squares(val number: Int) {
    fun squareOfSum(): Int = ((number * (number + 1)) / 2).square()

    fun sumOfSquares(): Int = (number * (number + 1) * (2 * number + 1)) / 6

    fun difference(): Int = squareOfSum() - sumOfSquares()

    private fun Int.square(): Int = this * this
}
```

### Common suggestions
* Creating an extension function like `Int.square()` makes life slightly easier
* Pointers to the closed-form formula can be found here: https://brilliant.org/wiki/sum-of-n-n2-or-n3/ 