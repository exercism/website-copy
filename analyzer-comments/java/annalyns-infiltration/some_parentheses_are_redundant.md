# Some parentheses are redundant

If you use an `||` expression to OR two smaller expressions and either expression is surrounded by parentheses and only ANDs some terms together (e.g. `knightIsAwake || (archerIsAwake && !prisonerIsAwake)`), the parentheses can be omitted because `&&` has the higher precedence over `||`:

```java
// instead of
knightIsAwake || (archerIsAwake && !prisonerIsAwake);

// use
knightIsAwake || archerIsAwake && !prisonerIsAwake;
```

Please note that, in certain complex cases, using parentheses can improve readability and understanding of the condition.
