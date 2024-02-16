# Mentoring

## Reasonable Solutions

```kotlin
class Anagram(var anagram: String){
    fun match(list: List<String>): Set<String>{
        return list.filter {
            it.lowercase() != anagram.lowercase() && it.order() == anagram.order()
        }.toSet()
    }

    private fun String.order(): List<Char>{
        return this.map { it.lowercaseChar() }.sorted()
    }
}
```

## Common suggestions

* Function `sorted()` can be used to sort according to the characters natural sort order
