# Mentoring

## Reasonable solutions

```java
class Hamming {
    private final String leftStrand, rightStrand;

    Hamming(String leftStrand, String rightStrand) {
        if (leftStrand.length() != rightStrand.length())
            throw new IllegalArgumentException("leftStrand and rightStrand must be of equal length.");
        this.leftStrand = leftStrand;
        this.rightStrand = rightStrand;
    }

    int getHammingDistance() {
        int hammingDistance = 0;
        for (int i = 0; i < leftStrand.length(); i++) {
            if (leftStrand.charAt(i) != rightStrand.charAt(i)) hammingDistance++;
        }
        return hammingDistance;
    }
}
```

```java
import java.util.stream.IntStream;

class Hamming {
    private char[] leftStrand, rightStrand;

    Hamming(String leftStrand, String rightStrand) {
        if (leftStrand.length() != rightStrand.length())
            throw new IllegalArgumentException("leftStrand and rightStrand must be of equal length.");
        this.leftStrand = leftStrand.toCharArray();
        this.rightStrand = rightStrand.toCharArray();
    }

    int getHammingDistance() {
        return (int) IntStream.range(0, leftStrand.length).filter(i -> leftStrand[i] != rightStrand[i]).count();
    }
}
```


## Common suggestions

- Use [Java 8 IntStream](https://docs.oracle.com/javase/8/docs/api/java/util/stream/IntStream.html) to avoid using ```for``` and ```if``` statements.
