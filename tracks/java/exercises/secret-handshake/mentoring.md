### Points to consider in this task

* binary numeral system understanding
* Java bitwise operators usage
* Java enum `ordinal` and `values` methods usage

### Bad practices
* converting number to binary string and parsing resulting string char by char 

### Reasonable solutions

#### Using the `ordinal`, `values` methods to calculate a bit mask

`HandshakeCalculator.java`
```java
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

class HandshakeCalculator {

    private static final int REVERSE_MASK = (int) Math.pow(2, 4);

    List<Signal> calculateHandshake(int number) {
        List<Signal> result = new LinkedList<>();
        for (Signal signal : Signal.values()) {
            int bitMask = (int) Math.pow(2, signal.ordinal());
            if ((number & bitMask) == bitMask) result.add(signal);
        }
        if ((number & REVERSE_MASK) == REVERSE_MASK) {
            Collections.reverse(result);
        }
        return result;
    }

}
```

#### Modifying enum to store a bit mask

`Signal.java`
```java
enum Signal {

    WINK(1), DOUBLE_BLINK(2), CLOSE_YOUR_EYES(4), JUMP(8);

    private int bitMask;

    Signal(int bitMask) {
        this.bitMask = bitMask;
    }

    public boolean isSignalAcceptable(int number) {
        return (number & this.bitMask) == bitMask;
    }
}
```

`HandshakeCalculator.java`
```java
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

class HandshakeCalculator {

    private static final int REVERSE_MASK = 16;

    List<Signal> calculateHandshake(int number) {
        List<Signal> result = Arrays.stream(Signal.values())
                .filter(signal -> signal.isSignalAcceptable(number))
                .collect(Collectors.toList());

        if ((number & REVERSE_MASK) == REVERSE_MASK) Collections.reverse(result);

        return result;
    }

}
```
