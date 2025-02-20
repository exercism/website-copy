# prefer extracted top level constant

Consider extracting the constant to the top level scope:

```javascript
const %{name} = %{value}

// the rest of your code below it
export const decodedValue = (...)
```

Only functions, classes and constants that are `export`ed, are visible and
accessible from the outside. These constants can live in the same
file without being exposed to other code. Also, extracting constants saves memory 
by avoiding repeated allocations in functions when those same constants are reused.
