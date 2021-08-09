# import ANSI with :except

The instructions mention "You're planning to add support for other car colors, so you want to import the whole module", minus the conflicting `color` function. To do that, use the `:except` option like so:

```elixir
import IO.ANSI, except: [color: 1]
```
