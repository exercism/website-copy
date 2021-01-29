Instead of defining the constant _inside_ the function, consider extracting it
to the top-level. Constants, functions and classes that are not `export`ed,
are not accessible from outside the file.

```javascript
const %{name} = %{value}

export const gigasecond = (...)
```
