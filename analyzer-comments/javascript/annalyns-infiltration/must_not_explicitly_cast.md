Remove all explicit calls to `Boolean(...)`.

In JavaScript, the result of an expression does not need to be _cast_ to a specific type.
For example, the result of a binary expression can be returned as is, and does not require another call to make it a `boolean`.

```javascript
// instead of
return Boolean(some_expression);

// ...In JavaScript, in general, values don't need to be explicitly changed
return some_expression;
```
