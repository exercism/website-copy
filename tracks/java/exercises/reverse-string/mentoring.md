### Reasonable solutions

Loop-based solution:
```java
class ReverseString {
    String reverse(String inputString) {
        String output = "";
        for (int i = inputString.length() - 1; i >= 0; i--) {
          output += inputString.charAt(i);
        }
        return output;
    }
}
```

Java8 `IntStream`-based solution:
```java
import java.util.stream.IntStream;

class ReverseString {
    String reverse(String inputString) {
        final int length = inputString.length();
        return IntStream.iterate(length-1, i-> i-1).limit(length)
                .mapToObj(inputString::charAt)
                .collect(StringBuilder::new, StringBuilder::append, StringBuilder::append).toString();
    }
}
```

`StringBuffer` (or `StringBuilder`)-based trivial solution:
```java
class ReverseString {
    String reverse(String inputString) {
        return new StringBuffer(inputString).reverse().toString();
    }
}
```

### Common suggestions

- Some students may submit a recursive solution. Warn them about performance issues in this case.
