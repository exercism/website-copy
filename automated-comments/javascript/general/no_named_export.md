No [export](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export)
called `%<export.name>s` was found. The tests won't pass without it.

Ensure `%<export.name>s` exists and add `export` in front of it:
```javascript
// exporting a "const"
export const %<export.name>s = /*...*/

// exporting a named function declaration
export function %<export.name>s() { /* ... */ }
```
