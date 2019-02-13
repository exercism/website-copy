### Reasonable solutions

#### Using a Hashmap
```java
import java.util.HashMap;
import java.util.Map;

class Scrabble {

    private final String word;
    private static final Map<Integer, Integer> LETTER_VALUES = new HashMap<>();

    static {
        add("AEIOULNRST", 1);
        add("DG", 2);
        add("BCMP", 3);
        add("FHVWY", 4);
        add("K", 5);
        add("JX", 8);
        add("QZ", 10);
    }

    private static void add(String letters, int score) {
        letters.chars().forEach(c -> LETTER_VALUES.put(c, score));
    }

    Scrabble(String word) {
        this.word = word.toUpperCase().replaceAll("\\W", "");
    }

    int getScore() {
        return word
                .chars()
                .map(LETTER_VALUES::get)
                .sum();
    }
}
```

#### Without a Hashmap
```java
class Scrabble {

    private final String word;

    Scrabble(String word) {
        this.word = word.toUpperCase().replaceAll("\\W", "");
    }

    int getScore() {
        return word.chars().map(this::getValue).sum();
    }

    private int getValue(int character) {
        String letter = Character.toString((char) character);
        return letter.isEmpty() ? 0
                : "AEIOULNRST".contains(letter) ? 1
                : "DG".contains(letter) ? 2
                : "BCMP".contains(letter) ? 3
                : "FHVWY".contains(letter) ? 4
                : "K".contains(letter) ? 5
                : "JX".contains(letter) ? 8
                : "QZ".contains(letter) ? 10
                : 0;
    }
}
```
