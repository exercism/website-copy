# Mentoring

## Reasonable solutions

Try and guide the students towards a for-loop based solution as this requires no imports and thus can be solved with the knowledge they have so far.

```java
public class PangramChecker {
    public boolean isPangram(String input) {
        boolean[] present = new boolean[26];

        // Loop over the alphabet and mark if letter is present
        for (char c : input.toLowerCase().toCharArray()) {
            if ('a' <= c && c <= 'z') {
                present[c - 'a'] = true;
            }
        }

        // Loop over the alphabet once more and check if a character
        // haven't been found and return false if a letter is missing
        for (boolean isPresent : present) {
            if (!isPresent) {
                return false;
            }
        }
        
        return true;
    }
}
```

Alternatively try to guide the students towards a solutions based on set theory as this makes for a simpler solution, but it requires knowledge about Java collections.
```java
import java.util.HashSet;
import java.util.Set;

public class PangramChecker {
    public boolean isPangram(String input) {
        Set<Character> set = new HashSet<>();
        for(char c : input.toLowerCase().toCharArray())
            set.add(c);

        Set<Character> alpha = new HashSet<>();
        for(char c : "abcdefghijklmnopqrstuvwxyz".toCharArray())
            alpha.add(c);

        // Check if the alphabet is a subset of the input
        return set.containsAll(alpha);
    }
}
```

## Common suggestions

- Suggest using `StringBuilder` instead of String concatenating when the students are concatenating within a for-loop

## Talking points

- Short-circuit evaluation, so you don't have to check the entire alphabet twice

## Changelog
