# no stopwatch type alias

In this exercise, you are meant to define `Stopwatch` as an opaque type.
Using `type alias Stopwatch` defines `Stopwatch` as a type alias, which exposes its inner structure.
Instead, use `type Stopwatch` to hide the inner structure and prevent other modules to deconstruct or directly update `Stopwatch` values.
