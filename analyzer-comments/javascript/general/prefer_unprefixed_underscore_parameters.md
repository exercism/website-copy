# prefer unprefixed underscore parameters

Unlike other languages, `_identifier` does not signify a **private** function, parameter, or variable.

Instead, in Javascript, prefixing a parameter with an underscore will stop
most IDEs from highlighting that parameter if it's unused. Remove the underscore
(`_`) from the start of `%{parameter.name}`, in order to fix this.
