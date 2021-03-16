# prefer top level constant

Consider extracting the `GIGASECOND` number into a constant:

```javascript
const %{name} = %{value}

// the rest of your code below it
export const gigasecond = (...)
```

Only functions, classes and constants that are `export`ed, are visible and
accessible from the outside. It usually makes sense to give [magic numbers](https://en.wikipedia.org/wiki/Magic_number_%%28programming%%29)
a name, which improves maintainability. These constants can live in the same
file without being exposed to other code.
