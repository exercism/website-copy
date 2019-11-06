### Reasonable Solutions
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
