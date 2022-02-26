# Mentoring

## Reasonable solutions

```java
class Twofer {
  String twofer(String name) {
    return "One for " + (name == null ? "you" : name) + ", one for me.";
  }
}
```

```java
import java.util.Optional;

class Twofer {
  String twofer(String name) {
    return "One for " + Optional.ofNullable(name).orElse("you") + ", one for me.";
  }
}
```

```java
import java.util.Objects;

class Twofer {
  String twofer(String name) {
    return "One for " + Objects.toString(name, "you") + ", one for me.";
  }
}
```

### Not recommended

Although `String.format` is a wonderful and powerful method, it is extremely slow for a problem that only requires simple `String` concatenation with the `+` operator.
For more information about the performance of `String.format`, check out [Java String Concatenation: Which Way Is Best?](https://redfin.engineering/java-string-concatenation-which-way-is-best-8f590a7d22a8).

```java
class Twofer {
  String twofer(String name) {
    return String.format("One for %s, one for me.", name == null ? "you" : name);
  }
}
```

Although we have not benchmarked it directly, the same template parsing problem exists for `MessageFormat`, so it very likely has the same performance issues.

```java
import java.text.MessageFormat;

class Twofer {
  String twofer(String name) {
    return MessageFormat.format("One for {0}, one for me.", name == null ? "you" : name);
  }
}
```

### Common suggestions

- Avoid code duplication: instead of using an `if` statement, consider using a single expression
- Define a constant variable (`private static final`) for the immutable string
- Use `Objects.toString()` (Java 7) or `Optional` (Java 8) to manage default value

### Talking points

Many submitted solutions re-assign the input parameter (`name`). While there is technically nothing wrong with this, you could suggest not to re-use the parameter but instead introduce a new variable. Reference: https://pmd.sourceforge.io/pmd-5.0.1/rules/java/design.html
