### Reasonable solutions

```java
import java.time.LocalDate;
import java.time.LocalDateTime;

class Gigasecond {
    private static final long GIGA_SECOND = 1_000_000_000;

    private final LocalDateTime birthDateTime;

    Gigasecond(LocalDate birthDate) {
        this(birthDate.atStartOfDay());
    }

    Gigasecond(LocalDateTime birthDateTime) {
        this.birthDateTime = birthDateTime;
    }

    LocalDateTime getDate() {
        return birthDateTime.plusSeconds(GIGA_SECOND);
    }
}
```


### Common suggestions

- Define a constant (`static final`) for gigasecond.
- Use [Java 7 Underscores in Numeric Literals](https://docs.oracle.com/javase/7/docs/technotes/guides/language/underscores-literals.html) to make the gigasecond constant easier to read.
  - Other good solutions are `(long) 1e9` (for those used to scientific notation) and `1000 * 1000 * 1000` (for those who are stuck with Java 6).
- Use constructor chaining to avoid code duplication.
- Use [`LocalDate.atStartOfDay()`](https://docs.oracle.com/javase/8/docs/api/java/time/LocalDate.html#atStartOfDay--) to convert a `LocalDate` to a `LocalDateTime`.


### Talking points

#### Eager computation

A student can choose to compute the result for `getDate()` in the constructor. It is a really good optimization. In that case, it should be noted that it is possible because the `birthDate` is only provided in the constructor and is immutable.

#### Type safety

We can add more type safety by using the class `java.time.Duration` for the gigasecond constant.

```java
private static final Duration GIGA_SECOND = Duration.ofSeconds(1_000_000_000);
```

Then the computation is a little less verbose.

```java
birthDateTime.plus(GIGA_SECOND);
```
