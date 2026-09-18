# prefer string concatenation

Although `String.format` and `String.formatted()` are wonderful and powerful methods, they are slower for a problem that only requires simple `String` concatenation with the `+` operator.
For more information about the performance of `String.format` and `String.formatted()`, check out [Java String Concatenation: Which Way Is Best?](https://redfin.engineering/java-string-concatenation-which-way-is-best-8f590a7d22a8).

Use `String` concatenation.
