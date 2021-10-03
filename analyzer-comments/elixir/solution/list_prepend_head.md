# use `[item | list]` to prepend items to lists

Using `[item] ++ list` instead of `[item | list]` is longer and less intention-revealing (prepending to list that looks like list concatenation).
Use `[item | list]` syntax to prepend to lists.
