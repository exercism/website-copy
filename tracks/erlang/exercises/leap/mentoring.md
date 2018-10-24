### Reasonable solutions

#### Using guards

```erl
leap_year(Y) when Y rem 400 =:= 0 -> true;
leap_year(Y) when Y rem 100 =:= 0 -> false;
leap_year(Y) when Y rem   4 =:= 0 -> true;
leap_year(Y) when is_integer(Y) -> false.
```

### Using a single expression

```erl
leap_year(Y) ->
  (Y rem 400 =:= 0) orelse (Y rem 100 =:= 0) orelse (Y rem 4 =:= 0).
```

### Common suggestions

* Instead of using several, potentially nested `if` or `case`
  expressions, suggest to replace it by guards or a single boolean
  expression using `or`, `orelse`, `and`, and `andalso`.
* Instead of literally returning `true` and `false` (eg. `case Y rem
  400 of 0 -> true; _ -> false end`), suggest to simply return the
  boolean condition (`Y rem 400 =:= 0`).

### Talking points

* Short-Circuit (`orelse`/`andalso`) vs. fully evaluating boolean
  operators (`or`/`and`).
* crashing vs returning `false` on invalid input.


<!-- Local Variables: -->
<!-- mode: gfm -->
<!-- End: -->
