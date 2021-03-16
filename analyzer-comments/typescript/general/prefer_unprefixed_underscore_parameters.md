# prefer unprefixed underscore parameters

Unlike other languages, `_identifier` does not signify a **private** function, parameter, or variable.

Instead, in TypeScript, prefixing a parameter with an underscore will stop
many IDEs from highlighting that parameter if it's unused. Remove the underscore
(`_`) from the start of `%{parameter.name}`, in order to fix this.
