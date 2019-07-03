Define a parameter called `%<splat-arg.name>s` with the type `%<parameter.type>s`,
instead of using `...%<splat-arg.name>s: %<parameter.type>s[]`.

[Rest parameters / splat arguments](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/rest_parameters)
are great if the function doesn't dictate how many values it wants to receive,
but in this case it is clearly defined how many values the function will be
called with.
