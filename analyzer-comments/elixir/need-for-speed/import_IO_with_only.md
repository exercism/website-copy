# import IO with :only

When importing functions from a module, it is good practice to import an explicit list, using the `:only` option, like so:

```elixir
import IO, only: [inspect: 2, write: 1]
```
