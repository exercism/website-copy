### Reasonable Solutions

```kotlin
class BankAccount {
    private var _balance: Int = 0
    private var open = true
    val balance: Int
        get() {
            check(open)
            return _balance
        }

    @Synchronized
    fun adjustBalance(amount: Int) {
        check(open)
        _balance += amount
    }

    fun close() {
        open = false
    }
}
```
