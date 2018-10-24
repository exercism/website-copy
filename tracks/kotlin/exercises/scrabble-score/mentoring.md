### Reasonable Solutions
```kotlin
object ScrabbleScore {
    fun scoreWord(input: String): Int =
            input.toUpperCase().sumBy {
                when (it) {
                    'A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T' -> 1
                    'D', 'G' -> 2
                    'B', 'C', 'M', 'P' -> 3
                    'F', 'H', 'V', 'W', 'Y' -> 4
                    'K' -> 5
                    'J', 'X' -> 8
                    'Q', 'Z' -> 10
                    else -> throw IllegalArgumentException("Unknown letter")
                }
            }
}
```

### Common suggestions
* Use `when` instead of nested `if` expressions
* In the `when` expression, group letters with the same value instead of creating one row per letter 
* Remember to convert the letters to uppercase or compare with both lower and uppercase
* You can use `sumBy` on the input string, or combine `map` and `sum`