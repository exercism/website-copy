### Reasonable Solutions

Solution with `java.util.Random`:
```kotlin
import java.util.Random
 
 private val random = Random()
 private fun List<*>.randomSample(n: Int) = (0 until n).map { this[random.nextInt(this.size)] }
 private val names = mutableSetOf<String>()
 private val letters = ('A'..'Z').toList()
 private val numbers = ('0'..'9').toList()
 
 class Robot {
     var name: String
 
     init {
         name = generateName()
     }
 
     fun reset() {
         name = generateName()
     }
 
     private tailrec fun generateName(): String {
         val name = letters.randomSample(2).plus(numbers.randomSample(3)).joinToString("")
         return when {
             names.add(name) -> name
             else -> generateName()
         }
     }
 }
```

Solution with `shuffled()`:
```kotlin
class Robot {
    var name: String = ""

    companion object {
        val usedNames = mutableListOf<String>()
    }

    init {
        reset()
    }

    fun reset() {
        while (name.isEmpty() || usedNames.contains(name)) {
            name = randomizeName()
        }
        usedNames.add(name)
    }

    private fun randomizeName(): String {
        val letters = ('A'..'Z').random(2)
        val numbers = (0..9).random(3)
        return letters + numbers
    }

    private fun <T> Iterable<T>.random(count: Int): String {
        return (0 until count)
                .map { this.toList().shuffled()[0] }
                .joinToString("")
    }
}
```


### Common suggestions
* Remember to save a global list with used names and to check newly generated names against it
* You can either use `java.util.Random` object to generate random items or the more Kotlinish variant with `shuffle()`
* Defining an extension method on `List<T>` or `Iterable<T>` to generate random elements makes your code very readable