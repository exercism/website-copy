# Mentoring

## Reasonable Solutions

### Using Streams

```java
public class IsogramChecker {
    public boolean isIsogram(String word) {

        String noSpacesOrHyphens = word.replaceAll("(?:\\s|-)", "").toLowerCase();

        return noSpacesOrHyphens.chars().distinct().count() == noSpacesOrHyphens.length();        
    }
}

```

### Using a Set

```java
class IsogramChecker {
  public boolean isIsogram(String input) {
    Set<Character> tmp = new HashSet<Character>();
    for(char ch : input.toLowerCase().toCharArray()) {
        if (Character.isLetter(ch) && !tmp.add(ch)) {
            return false;
        }
    }
    return true;
  }
}
```

## Talking points

- Solutions that use the Collections Framework should opt for a Set interface to check for duplicates instead of Maps and Lists. Sets do not allow duplicates, so they are the best fit for this check.
- The `add()` method in the Set interface returns a `boolean` value indicating if the value is already present or not. This can be used to stop code execution earlier, instead of building the entire Set and later on checking its size against the original String.
- For brute force solutions that check every character against every other character in the string (n² time complexity), you may point to the strategies above to improve efficiency.
