# Mentoring

## Reasonable solutions

A straightforward and easy to read solution for this problem.

```java

class MicroBlog {
  public String truncate(String input) {
    
    if (input.length() > 5) {
      int[] myCodePoints = input.codePoints().toArray();

      StringBuilder myBuilder = new StringBuilder();
      for (int i = 0; i < 5; i++) {
        myBuilder.appendCodePoint(myCodePoints[i]);
      }

      return myBuilder.toString();
    } else 
      return input;

  }
}
```

A bit more compact code that benefits from functionality of streams and string constructor for code points.

```java
class MicroBlog {
  public String truncate(String input) {
    
    if (input.length() > 5)
      return new String(input.codePoints().limit(5).toArray(),0,5);
    else
      return input;

  }
}
```

Same code as above except now it just fashioned into a one-liner.

```java
class MicroBlog {
  public String truncate(String input) {
  
    return input.length() > 5 ? new String(input.codePoints().limit(5).toArray(),0,5) : input;
    
  }
}
```

## Common suggestions

- As a starting point, suggest using [`input.codePoints()`][Charsequence#codePoints] to convert the string to code points.
- `StringBuilder.appendCodePoint` and `new String(new int[] { codePoints }, 0, codePointCount)` can be used for translation from code point to string. 
- Input length can be checked to ignore smaller inputs for efficiency.

## Talking points

- Keep it simple! Proper use of common apis provides pleasant programs (probably).

[Charsequence#codePoints]: https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/CharSequence.html#codePoints()
