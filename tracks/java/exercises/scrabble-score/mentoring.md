# Mentoring

### Reasonable solutions

#### Using int array for mapping letters to scores:
```java
class Scrabble {
    private final String word;

    private final static int[] scores = initializeScores();

    private static int[] initializeScores() {
        int scores[] = new int['Z' - 'A' + 1];
        Stream.of(new int[][] {
                {'A',1}, {'B',3}, {'C',3}, {'D',2}, {'E',1}, {'F',4}, {'G',2}, {'H',4}, {'I',1},
                {'J',8}, {'K',5}, {'L',1}, {'M',3}, {'N',1}, {'O',1}, {'P',3}, {'Q',10}, {'R',1},
                {'S',1}, {'T',1}, {'U',1}, {'V',4}, {'W',4}, {'X',8}, {'Y',4}, {'Z',10}
        }).forEach(pair -> scores[pair[0] - 'A'] = pair[1]);
        return scores;
    }

    Scrabble(String word) {
        this.word = word.toUpperCase();
    }

    int getScore() {
        return word.chars().map(c -> scores[c - 'A']).sum();
    }
}
```

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

#### Using Java 9 Map factory methods
```java
private static final Map<Character, Integer> SCORES = Map.ofEntries(
    entry('a', 1),
    entry('e', 1),
    entry('i', 1),
    entry('o', 1),
    entry('u', 1),
    entry('l', 1),
    entry('n', 1),
    entry('r', 1),
    entry('s', 1),
    entry('t', 1),
    entry('d', 2),
    entry('g', 2),
    entry('b', 3),
    entry('c', 3),
    entry('m', 3),
    entry('p', 3),
    entry('f', 4),
    entry('h', 4),
    entry('v', 4),
    entry('w', 4),
    entry('y', 4),
    entry('k', 5),
    entry('j', 8),
    entry('x', 8),
    entry('q', 10),
    entry('z', 10)
);
```
