### Reasonable Solutions
```kotlin
import java.time.LocalDate
import java.time.LocalDateTime

class Gigasecond(birthTime: LocalDateTime) {
    constructor(birthDate: LocalDate) : this(birthDate.atStartOfDay())

    val date: LocalDateTime = birthTime.plusSeconds(1E9.toLong())
}
```

### Common suggestions
* Use method `LocalDate.atStartOfDay()` to convert a `LocalDate` to a `LocalDateTime`
* Use method `LocalDateTime.plusSeconds()` to add gigaseconds
* You can use `1_000_000_000` or `1E9` to represent a giga 
