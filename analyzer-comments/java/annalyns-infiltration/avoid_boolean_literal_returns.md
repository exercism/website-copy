# Avoid Boolean literal returns

Instead of returning boolean literals after a condition, you can directly return the condition instead.

Example :

```java
// instead of
if (someExpression) {
  return true;
} else {
  return false;
}

// ... return the expression directly
return someExpression;
```
