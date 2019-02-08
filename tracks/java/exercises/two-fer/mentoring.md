### Reasonable solutions

```java
class Twofer {
  String twofer(String name) {
    return String.format("One for %s, one for me.", name == null ? "you" : name);
  }
}
```

```java
import java.util.Optional;

class Twofer {
  String twofer(String name) {
    return String.format("One for %s, one for me.", Optional.ofNullable(name).orElse("you"));
  }
}
```

```java
import java.util.Optional;

class Twofer {
  String twofer(String name) {
    return String.format("One for %s, one for me.", Objects.toString(name, "you"));
  }
}
```

### Common suggestions

- Avoid code duplication: instead of using an `if` statement, consider using a single expression
- Define a constant variable (`private static final`) for the immutable string
- Prefer the use of `String.format()` over string concatenation as in ` "One for " + name + ", one for me."` for better readability
- Use `Objects.toString()` (Java 7) or `Optional` (Java 8) to manage default value

### Talking points

Many submitted solutions re-assign the input parameter (`name`). While there is technically nothing wrong with this, you could suggest not to re-use the parameter but instead introduce a new variable. Reference: https://pmd.sourceforge.io/pmd-5.0.1/rules/java/design.html
