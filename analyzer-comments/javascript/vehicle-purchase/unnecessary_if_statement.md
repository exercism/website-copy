# unnecessary if statement

Instead of creating an `if (...) {}` block, leverage the boolean value directly
that can be returned from checking the value of the parameter.

For example, the following:

```javascript
if (param === true) {
  return true;
}
```

can be turned into:

```javascript
return param === true;
```
