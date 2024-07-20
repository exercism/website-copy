# Avoid comparison with boolean literals

Instead of comparing booleans with the literal values, it can be simplified to just the variables:

```java
// instead of
return someBoolVariable == true;

// use
return someBoolVariable;
```
