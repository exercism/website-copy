### Reasonable solutions

```java
class Twofer {
  String twofer(String name) {
    return String.format("One for %s, one for me.", name == null ? "you" : name);
  }
}
```

```java
class Twofer {
  String twofer(String name) {
    if (name == null) {
      name = "you";
    }
    return String.format("One for %s, one for me.", name);
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

- Prefer the use of `String.format()` over string concatenation as in ` "One for " + name + ", one for me."` 
  for better readability.
- Use Optional for optional arguments
- Use `Objects.toString()` for defaults

### Talking points

Is it ok to overwrite the name argument?
