# Mentoring

### Reasonable Solutions
```kotlin
fun twofer(who: String = "you") = "One for $who, one for me."
```

### Common suggestions
* Use default argument values to avoid having to check for null value.
* Curley brackets are not required when embedding variables using string interpolation. Use them only when embedding an expression.
* When a function returns a [single expression](https://kotlinlang.org/docs/reference/functions.html#single-expression-functions), the curly braces can be omitted and the body is specified after `a = symbol`
