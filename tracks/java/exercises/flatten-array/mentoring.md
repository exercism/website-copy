### Reasonable Solutions

```java
import java.util.List;
import java.util.stream.Stream;

import static java.util.stream.Collectors.toList;

public class Flattener {

    public List<?> flatten(List<?> list) {
        return list.stream()
                .filter(item -> item != null)
                .flatMap(item -> {
                    if (item instanceof List) {
                        final List<?> listItem = (List<?>) item;
                        return flatten(listItem).stream();
                    } else {
                        return Stream.of(item);
                    }
                }).collect(toList());
    }
}
```
