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


### Common suggestions

- Use String#format or ` "One for " + name + ", one for me."`. To highlight that the method method performs string interpolation.
- Use Optional for optional arguments

### Talking points

Is it ok to overwrite the name argument?
