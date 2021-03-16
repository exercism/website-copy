# Mentoring

### Reasonable solutions

```erl
response(Str) ->
  response(Str, false, false, false, false).

response([], false, false, false, false) ->
  "Fine. Be that way!";
response([], true, false, _HasOther, false) ->
  "Whoa, chill out!";
response([], true, false, _HasOther, true) ->
  "Calm down, I know what I'm doing!";
response([], _HasUpper, _HasLower, _HasOther, false) ->
  "Whatever.";
response([], _HasUpper, _HasLower, _HasOther, true) ->
  "Sure.";
response([C|Str], HasUpper, HasLower, HasOther, MaybeQuestion) when C=<$\s ->
  response(Str, HasUpper, HasLower, HasOther, MaybeQuestion);
response([$?|Str], HasUpper, HasLower, HasOther, _MaybeQuestion) ->
  response(Str, HasUpper, HasLower, HasOther, true);
response([C|Str], _HasUpper, HasLower, HasOther, _MaybeQuestion) when C>=$A, C=<$Z ->
  response(Str, true, HasLower, HasOther, false);
response([C|Str], HasUpper, _HasLower, HasOther, _MaybeQuestion) when C>=$a, C=<$z ->
  response(Str, HasUpper, true, HasOther, false);
response([_|Str], HasUpper, HasLower, _HasOther, _MaybeQuestion) ->
  response(Str, HasUpper, HasLower, true, false).
```

### Common suggestions

* If the student is using regular expressions, ask for a solution that works
  without them.
* If the student is using the `string` module, ask for a solution that works
  without it. An exception could be if the student is trying to accomodate for
  unicode input.
* If the student's solution requires traversing the input string multiple
  times (to check for uppercase letters, lowercase letters, ...), ask for
  a solution that requires only one pass.

### Talking points

* Regular expressions vs pattern matching

<!-- Local Variables: -->
<!-- mode: gfm -->
<!-- End: -->
