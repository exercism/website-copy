The tests won't pass without an [export](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export) called `%{export.name}`.

You can export constants or functions like this:
```javascript
// exporting a "const"
export const %{export.name} = /*...*/

// exporting a named function declaration
export function %{export.name}() { /* ... */ }
```

Please ensure `%{export.name}` exists and that it has `export` in front of it.
