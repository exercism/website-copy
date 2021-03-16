# Mentoring

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
        return ((number >> position) & 1) == 1;
    }
}
```

#### Modifying the Signal enum

`Signal.java`:
```java
enum Signal {
    WINK(1), DOUBLE_BLINK(1 << 1), CLOSE_YOUR_EYES(1 << 2), JUMP(1 << 3), REVERSE(1 << 4);

    private final int bitmask;
    Signal(int bitmask) { this.bitmask = bitmask; }

    boolean isPresent(int number) {
        return (number & bitmask) == bitmask;
    }
}
```

`HandshakeCalculator.java`
```java
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class HandshakeCalculator {

    List<Signal> calculateHandshake(int number) {
        List<Signal> handshake = new ArrayList<Signal>();

        for (Signal signal : Signal.values()) {
            if (signal.isPresent(number)) {
                handshake.add(signal);
            }
        }
        if (handshake.remove(Signal.REVERSE)) {
            Collections.reverse(handshake);
        }
        return handshake;
    }
}
```
