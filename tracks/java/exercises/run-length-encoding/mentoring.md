# Mentoring

## Reasonable solutions

```java
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class RunLengthEncoding {
    public static final String DELIMITERS = "(?<=[a-zA-Z ])|(?<=\\d)(?=\\D)|(?<=\\D)(?=\\d)";
    public static final String IS_A_NUMBER = "[0-9]+";

    public String encode(String data) {

        final int length = data.length();
        StringBuilder encoded = new StringBuilder();

        for (int i = 0; i < length; i++) {
            int duplicates = 0;

            while (i < length - 1 && (data.charAt(i) == data.charAt(i + 1))) {
                duplicates++;
                i++;
            }

            if (duplicates != 0) {
                encoded.append(duplicates + 1);
            }

            encoded.append(data.charAt(i));
        }
        return encoded.toString();
    }

    public String decode(String data) {

        String[] split = data.split(DELIMITERS);
        StringBuilder decoded = new StringBuilder();

        for (int i = 0; i < split.length; i++) {
            if (split[i].matches(IS_A_NUMBER)) {
                decoded.append(expand(split[i + 1].charAt(0), Integer.valueOf(split[i])));
                i++;
            } else {
                decoded.append(split[i]);
            }
        }
        return decoded.toString();
    }

    private String expand(char character, int repeat) {
        return IntStream.range(0, repeat).mapToObj(x -> character).map(String::valueOf).collect(Collectors.joining(""));
    }
}
```
