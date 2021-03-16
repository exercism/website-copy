# Mentoring

## Reasonable solutions

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
import java.util.Arrays;
import java.util.Map;

import static java.util.function.Function.identity;
import static java.util.function.Predicate.not;
import static java.util.stream.Collectors.groupingBy;
import static java.util.stream.Collectors.summingInt;

public class WordCount {
    // Characters ignored in a phrase: space, newline, punctuation !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~ with the exception of simple quote
    private static final String IGNORED_CHARACTERS = "[ \n\\p{Punct}&&[^\\']]";

    public Map<String, Integer> phrase(String data) {
        return Arrays.stream(data.split(IGNORED_CHARACTERS))
                .filter(not(String::isEmpty))
                .map(this::stripQuotes)
                .map(String::toLowerCase)
                .collect(groupingBy(identity(), summingInt(word -> 1)));
    }

    private String stripQuotes(String word) {
        return word.replaceAll("^'|'$", "");
    }
}
```
