# Mentoring

## Reasonable solutions

```java
class RotationalCipher {
    private static final int UPPER_A = 'A';
    private static final int UPPER_Z = 'Z';
    private static final int LOWER_A = 'a';
    private static final int LOWER_Z = 'z';
    private static final int RANGE = UPPER_Z-UPPER_A+1;

    private final int shift;

    RotationalCipher(int shiftKey) {
        shift = shiftKey;
    }

    String rotate(String data) {
        return data.chars()
                .map(c -> rotate(c))
                .collect(
                        StringBuilder::new,
                        StringBuilder::appendCodePoint,
                        StringBuilder::append
                ).toString();
    }

    private int rotate(int c) {
        if (c >= UPPER_A && c <= UPPER_Z) {
            return (c + shift - UPPER_A) % RANGE + UPPER_A;
        } else if (c >= LOWER_A && c <= LOWER_Z) {
            return (c + shift - LOWER_A) % RANGE + LOWER_A;
        } else {
            return c;
        }
    }
}
```


