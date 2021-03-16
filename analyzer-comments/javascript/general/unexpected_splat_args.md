# unexpected splat args

Define a parameter called `%{splat-arg.name}` with the type `%{parameter.type}`,
instead of using `...%{splat-arg.name}: %{parameter.type}[]`.

[Rest parameters / splat arguments](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/rest_parameters)
are great if the function doesn't dictate how many values it wants to receive,
but in this case it is explicitly defined how many values the function will be
called with.
