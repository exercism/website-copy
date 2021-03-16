# Mentoring

### Reasonable Solutions

```kotlin
object BinarySearch {
    fun search(items: List<Int>, itemToFind: Int): Int =
        search(items, itemToFind, 0)

    private fun search(
        items: List<Int>,
        itemToFind: Int,
        lowerBoundAccumulator: Int
    ): Int {
        if (items.isEmpty()) return -1
        val middleIndex = items.size / 2

        if (items[middleIndex] == itemToFind) return middleIndex + lowerBoundAccumulator

        val (newLowerBound, newUpperBound) = if (items[middleIndex] < itemToFind) {
            Pair(middleIndex + 1, items.size)
        } else {
            Pair(0, middleIndex)
        }

        return search(
            items.subList(newLowerBound, newUpperBound),
            itemToFind,
            lowerBoundAccumulator + newLowerBound
        )
    }
}
```

### Common suggestions
* Use a second function to maintain state of the recursion.
