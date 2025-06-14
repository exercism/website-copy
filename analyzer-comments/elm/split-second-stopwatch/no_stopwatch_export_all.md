# no stopwatch export all

In this exercise, you are meant to define `Stopwatch` as an opaque type.
Exporting the type as `module SplitSecondStopwatch exposing (Stopwatch(..))` will expose its inner structure.
Remove `(..)` to hide the inner structure and prevent other modules to deconstruct or directly update `Stopwatch` values.
