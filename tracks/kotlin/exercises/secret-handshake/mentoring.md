# Mentoring

## Reasonable Solutions
```kotlin
object HandshakeCalculator {
    fun calculateHandshake(n: Int) =
        signals
            .filterIndexed { i, _ -> n hasBit i }
            .let { if (n hasBit signals.size) it.reversed() else it }

    private val signals = Signal.values()
    private infix fun Int.hasBit(n: Int) = this shr n and 1 == 1
}
```

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

        return if (shouldReverse(input)) signalsPresent.reversed() else signalsPresent
    }

    private fun shouldReverse(input: Int): Boolean = hasBitSet(input, 16)

    private fun isPresentIn(input: Int): (Map.Entry<Signal, Int>) -> Boolean = {
        hasBitSet(input, it.value)
    }

    private fun hasBitSet(input: Int, bit: Int): Boolean = input and bit == bit
}
```
