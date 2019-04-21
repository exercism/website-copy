### Reasonable Solutions
```kotlin
object Raindrops {
    fun convert(num: Int): String = buildString {
        if (num % 3 == 0) append("Pling")
        if (num % 5 == 0) append("Plang")
        if (num % 7 == 0) append("Plong")
        if (isEmpty()) append(num)
    }
}
```

```kotlin
object Raindrops {
    private val factorsToWords = mapOf(3 to "Pling", 5 to "Plang", 7 to "Plong")

    fun convert(input: Int): String {
        val words = factorsToWords.filterKeys { input % it == 0 }.values

        return if (words.isEmpty())
            input.toString()
        else
            words.joinToString("")
    }
}
```

### Common suggestions
* The first solution uses [buildString](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.text/build-string.html) to create a `StringBuilder` using provided `append`s and then converting it to String.
* The second solution defines a map of numbers to strings and then use [filterKeys](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/filter-keys.html) which returns a map containing all key-value pairs with keys matching the given predicate.