# Mentoring

### Reasonable solutions

Loop-based solution (see remarks in common suggestions):
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

`StringBuilder`-based trivial solution:
```java
class ReverseString {
    String reverse(String inputString) {
        return new StringBuilder(inputString).reverse().toString();
    }
}
```

### Common suggestions

- Some students may submit a recursive solution. Warn them about performance issues in this case.
- Some students may submit a solution that builds new strings. Since this has a memory overhead of copying the entire output string once for each character in it, a solution based on StringBuilder is preferred.
- Note that, to increase the performance of repeated string concatenation, a Java compiler may use the StringBuffer class or a similar technique to reduce the number of intermediate String objects that are created by evaluation of an expression.
