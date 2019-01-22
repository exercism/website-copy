### Reasonable Solutions

```kotlin
class RotationalCipher(private val key: Int) {
    init {
        require(key in 0..26) {
            "Key should be integer between 0 and 26"
        }
    }

    fun encode(input: String): String =
            input.map(shiftBy(key)).joinToString("")

    // Do not allow private members to access object state.
    // This allows for easier refactoring to another object
    // because their state is self contained.
    private fun shiftBy(key: Int): (Char) -> Char = {
        if (shouldNotShift(it)) it
        else doShift(key, it)
    }

    private fun doShift(key: Int, c: Char): Char {
        val mod = 26
        val shift = if (c.isUpperCase()) {
            65
        } else {
            97
        }

        return ((c.toInt() + key - shift) % mod + shift).toChar()
    }

    private fun shouldNotShift(c: Char): Boolean {
        val symbolRange = 32..64
        return c.toInt() in symbolRange
    }
}
```

Thanks go out to (Xifax)[https://exercism.io/profiles/Xifax] for the inspiration.

### Common suggestions
