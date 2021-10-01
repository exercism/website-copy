Remove all unnecessary literals.

In JavaScript it's not necessary to `return` the literal `true` or `false` in order to return a boolean.
The result of an expression can be returned directly.

```javascript
// instead of
if (some_expression) {
  return true;
} else {
  return false;
}

// ...in JavaScript, these can be returned directly
return some_expression;
```
