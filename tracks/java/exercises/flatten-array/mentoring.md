# Mentoring

## Reasonable Solutions

Stream-based solution:
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

Loop-based solution:
````java
import java.util.ArrayList;
import java.util.List;

class Flattener {

    public List<?> flatten(List<?> list) {
        final List<Object> newList = new ArrayList<>();

        for (Object item : list) {
            if (item != null) {
                if (item instanceof List<?>) {
                    newList.addAll(flatten((List<Object>) item));
                }
                else{
                    newList.add(item);
                }
            }
        }
        return newList;
    }
}
``