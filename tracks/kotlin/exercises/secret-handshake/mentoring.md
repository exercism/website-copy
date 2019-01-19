### Reasonable Solutions
```kotlin
object HandshakeCalculator {
    fun calculateHandshake(input: Int): List<Signal> {
        val signalMap = mapOf(
                Signal.WINK to 1,
                Signal.DOUBLE_BLINK to 2,
                Signal.CLOSE_YOUR_EYES to 4,
                Signal.JUMP to 8
        )

        val signalsPresent = signalMap.filter(isPresentIn(input)).keys.toList()

        return if (shouldReverse(input)) {
            signalsPresent.reversed()
        } else {
            signalsPresent
        }
    }

    private fun shouldReverse(input: Int): Boolean {
        return input and 16 == 16
    }

    private fun isPresentIn(input: Int): (Map.Entry<Signal, Int>) -> Boolean = {
        input and it.value == it.value
    }
}
```

### Common suggestions
