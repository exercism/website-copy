Unlike other languages, `_parameter` does not signify a *private* variable.

Instead, in Javascript, prefixing a parameter with an underscore will stop
most IDEs from highlighting that parameter if it's unused. Remove the underscore
(`_`) from the start of `%<parameter.name>s`, in order to fix this.
