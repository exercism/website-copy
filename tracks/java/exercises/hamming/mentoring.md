### Reasonable solutions

```java
class Hamming {
    private final String leftStrand, rightStrand;

    Hamming(String leftStrand, String rightStrand) {
        validateLengths(leftStrand, rightStrand);
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

    private void validateLengths(String leftStrand, String rightStrand){
        if (leftStrand.length() != rightStrand.length()){
            if(leftStrand.isEmpty())
                throw new IllegalArgumentException("left strand must not be empty.");
            if(rightStrand.isEmpty())
                throw new IllegalArgumentException("right strand must not be empty.");
            throw new IllegalArgumentException("leftStrand and rightStrand must be of equal length.");
        }
    }
}
```

```java
import java.util.stream.IntStream;

class Hamming {
    private char[] leftStrand, rightStrand;

    Hamming(String leftStrand, String rightStrand) {
        validateLengths(leftStrand, rightStrand);
        this.leftStrand = leftStrand.toCharArray();
        this.rightStrand = rightStrand.toCharArray();
    }

    int getHammingDistance() {
        return (int) IntStream.range(0, leftStrand.length).filter(i -> leftStrand[i] != rightStrand[i]).count();
    }
        private void validateLengths(String leftStrand, String rightStrand){
        if (leftStrand.length() != rightStrand.length()){
            if(leftStrand.isEmpty())
                throw new IllegalArgumentException("left strand must not be empty.");
            if(rightStrand.isEmpty())
                throw new IllegalArgumentException("right strand must not be empty.");
            throw new IllegalArgumentException("leftStrand and rightStrand must be of equal length.");
        }
    }
}
```


### Common suggestions

- Use [Java 8 IntStream](https://docs.oracle.com/javase/8/docs/api/java/util/stream/IntStream.html) to avoid using ```for``` and ```if``` statements.
