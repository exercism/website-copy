### Reasonable solutions

Loop-based solution:
```java
import java.util.HashMap;
import java.util.Map;

class WordCount {

    public Map<String, Integer> phrase(String input) {
        Map<String, Integer> countMap = new HashMap<>();
        input = input.trim().toLowerCase().replaceAll("([^A-Za-z0-9']|\\B'|'\\B)", " ");
        String[] tokenizedInput = input.split("\\s+");
        for (String aWord : tokenizedInput) {
            if (aWord.isEmpty()) {
                continue;
            }
            Integer count = countMap.get(aWord);
            countMap.put(aWord, count == null ? 1 : count + 1);
        }
        return countMap;
    }
}
```

FP solution (Java 11):
```java
import java.util.AbstractMap;
import java.util.Arrays;
import java.util.Map;
import java.util.function.Predicate;

import static java.util.stream.Collectors.groupingBy;
import static java.util.stream.Collectors.summingInt;

public class WordCount {

    public Map<String, Integer> phrase(String data) {
        return Arrays.stream(data.split("[ \n\\p{Punct}&&[^\\']]"))
                .filter(Predicate.not(String::isEmpty))
                .map(this::stripQuotes)
                .map(String::toLowerCase)
                .map(word -> new AbstractMap.SimpleEntry<>(word, 1))
                .collect(groupingBy(entry -> entry.getKey(), summingInt(entry -> entry.getValue())));
    }

    private String stripQuotes(String word) {
        return word.replaceAll("^'|'$", "");
    }
}
```
