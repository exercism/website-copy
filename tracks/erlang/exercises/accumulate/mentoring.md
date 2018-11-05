### Reasonable solutions

#### Comprehension

```erl
accumulate(F, L) -> [F(X) || X <- L].
```

#### Tailrecursion

```erl
accumulate(F, L) -> accumulate(F, L, []).

accumulate(_, [], Acc) -> lists:reverse(Acc);
accumulate(F, [H|T], Acc) -> accumulate:(F, T, [F(H)|Acc]).
```

#### Fold

```erl
accumulate(F, L) -> lists:foldr(fun(E, Acc) -> [F(E)|Acc] end, [], L).
```

### Common suggestions

* If the student uses a comprehension, ask him to use recursion, if he
  uses recursion ask him to use a fold.  But do not push too hard.
  The main subject of this exercise is to show the student that
  functions are just values and you can pass them around and call
  them.
* In recursive versions, it is important to check if the
  implementation is indeed tail recursive.  When building a list it is
  not that important (we move allocations from stack to heap and still
  need to reverse afterwards), but tail recursiveness is a good habbit
  later on, when we have growing stack vs. near to constant memory.

### Talking points

* `foldl` vs. `foldr`

<!-- Local Variables: -->
<!-- mode: gfm -->
<!-- End: -->
