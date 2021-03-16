# Mentoring

_Two Fer_ is the first core exercise after _Hello, World_.
_Hello, World_ is auto-approved, so _Two Fer_ is the first exercise where someone will be blocked until a mentor approves their exercise, and also likely the first feedback they've ever gotten on their Elm code.

This is also going to be the most common exercise that we are asked to mentor, since some people will drop off after submitting just the one.

The goal of the exercise is to get acquainted with Elm. This is often an excellent place to start introducing people to the tooling.

## Reasonable solutions

We don't have any clear guidelines around when to approve.
Some people have been adding comments and approving straight away, others have been approving when the solution has a nice `Maybe.withDefault` in it.
It might be a good time to introduce it if the students are not using it and also a good time to point them to package.elm-lang.org since they are probably going to spend some time on it if they stick around.
A good solution might look like:

```elm
module TwoFer exposing (twoFer)


twoFer : Maybe String -> String
twoFer name =
    "One for " ++ Maybe.withDefault "you" name ++ ", one for me."
```

## Common suggestions

One mentor recommended to focus on a single thing, and only add other improvements as "food for thought" that the author can take with them as they move on to the next exercise.

The most common feedback revolves around:

* Readability (formatting, comments)
* General programming things (compound variable names, minimal conditionals)

