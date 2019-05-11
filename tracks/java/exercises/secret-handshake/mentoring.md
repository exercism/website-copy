### Reasonable solutions

#### Using the `ordinal()` method to check the bits
```java
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class HandshakeCalculator {

    List<Signal> calculateHandshake(int number) {
        List<Signal> result = new ArrayList<Signal>();

        for (Signal signal : Signal.values()) {
            if (bitIsSet(number, signal.ordinal())) {
                result.add(signal);
            }
        }

        if (bitIsSet(number, 4)) {
            Collections.reverse(result);
        }

        return result;
    }
    
    // NOTE: there are multiple ways to check if the bit is set
    boolean bitIsSet(int number, int position) {
        return ((number >> position) & 0x1) == 1;
    }
}
```

#### Modifying the Signal enum

`Signal.java`:
```java
enum Signal {
    WINK, DOUBLE_BLINK, CLOSE_YOUR_EYES, JUMP, REVERSE;

    boolean isBitSet(int number) {
        return ((number >> ordinal()) & 0x1) == 1;
    }
}
```

`HandshakeCalculator.java`
```java
import java.util.ArrayList;
import java.util.List;

class HandshakeCalculator {

    List<Signal> calculateHandshake(int number) {
        List<Signal> result = new ArrayList<Signal>();

        for (Signal signal : Signal.values()) {
            if (signal.isBitSet(number)) {
                if (signal == Signal.REVERSE) {
                    Collections.reverse(result);
                } else {
                    result.add(signal);
                }
            }
        }
        return result;
    }
}
```

### Common suggestions

- TODO: add some common suggestions here

### Talking points

- TODO: additional suggestions
