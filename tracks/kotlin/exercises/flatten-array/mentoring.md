### Reasonable Solutions

Solution with `flatMap()`:
```kotlin
object Flattener {
    fun flatten(list: List<Any?>): List<Any> = list.flatMap {
        if (it is List<Any?>) flatten(it)
        else listOf(it)
    }.filterNotNull()
}
```

Solution with `fold()`:
```kotlin
object Flattener {
    fun flatten(list: List<*>): List<Any> {
        return list.fold(emptyList()) { acc, item ->
            when (item) {
                is List<*> -> acc + flatten(item)
                null -> acc
                else -> acc + item
            }
        }
    }
}
```

### Common suggestions
* Remember that the solution must work for any type, not just `Int`s or lists on `Int`s (although the tests only test just these cases)
* The `filterNotNull()` function can make your life easier. Include the nulls in your preliminary list, then filter them out.
* As a challenge, try __not__ using library function `flatMap()`, and instead find a different way