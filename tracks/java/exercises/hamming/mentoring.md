### Reasonable solutions

```java
class Hamming {
    private String leftStrand, rightStrand;
    
    Hamming(String leftStrand, String rightStrand) {
        if (leftStrand.length() != rightStrand.length()) {
            throw new IllegalArgumentException("leftStrand and rightStrand must be of equal length.");
        this.leftStrand = leftStrand;
        this.rightStrand = rightStrand;
        }
    }

    int getHammingDistance() {
        int hammingDistance = 0;
        for (int i = 0; i < l.length; i++) {
            if (l[i] != r[i]) hammingDistance++;
        }
        return hammingDistance;
    }
}
```

```java
import java.util.stream.IntStream;

class Hamming {
    private char[] left, right;

    Hamming(String leftStrand, String rightStrand) {
        if (leftStrand.length() != rightStrand.length())
            throw new IllegalArgumentException("leftStrand and rightStrand must be of equal length.");
        left = leftStrand.toCharArray();
        right = rightStrand.toCharArray();
    }

    int getHammingDistance() {
        return (int) IntStream.range(0, left.length).filter(i -> left[i] != right[i]).count();
    }
}
```


### Common suggestions

- Use [Java 8 IntStream](https://docs.oracle.com/javase/8/docs/api/java/util/stream/IntStream.html) to avoid using ```for``` and ```if``` statements.
