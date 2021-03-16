# Mentoring

## Reasonable Solutions

```kotlin
class RotationalCipher(private val key: Int) {
    init {
        require(key in 0..26) {
            "Key should be integer between 0 and 26"
        }
    }

    fun encode(input: String): String =
            input.map(shiftBy(key)).joinToString("")

    private fun shiftBy(key: Int): (Char) -> Char = {
        if (it.isLetter()) doShift(key, it) else it
    }

    private fun doShift(key: Int, char: Char): Char {
        val mod = 26
        val shift = if (char.isUpperCase()) 65 else 97

        return ((char.toInt() + key - shift) % mod + shift).toChar()
    }
}
```

## Common suggestions
* Do not allow private members to access object state. This allows for easier refactoring to another object because their state is self contained.
