This is a good exercise to talk about bringing domain concepts (such as `isYelling`, `isQuestion` and so on) in to the code, as it is quite easy and most students will do it automatically.

This exercise introduces some string handling functions, such as `String.trim`, `String.endsWith`, `String.any`, `String.isEmpty`, `Char.isAlpa` and `Char.isUpper`

There are some good and sensible opportunities to use point free style.

There are also some general code quality things to discuss, such as keep related logic together, and ordering the code by importance. Students should strive to communicate what the code does in as few lines as possible (preferably just the main function and argument names). They show also strive to communicate how it does it in as few lines as possible, preferably just the main function body.

### Reasonable solutions

There are two main styles of solution.

One involves if statements and helper functions to calculate `isYelling` and suchlike. This is a good solution, but has the minor drawback that you either have to repeat some logic in the conditional statements (which is preferred), or use nested conditional statements (which should be avoided).

The other involves pattern matching with helper functions to calculate `isYelling` and suchlike. This often reads slightly better, but uses a few more lines of code.

Either solution is acceptable, and generally as long as the tests pass it is ok to approve any solution which isn't truly terrible. Comments should be added for any suggested improvements or talking points.

### Common suggestions

`isSilence` is easy to calculate, and is probably best as `String.trim remark |> String.empty remark` or `String.trim >> String.empty` (point free style)

`isQuestion` is easy to calculate, and is probably best as `String.trimRight remark |> String.endsWith "?" remark` or `String.trimRight >> String.endsWith "?"` (point free style)

`isYelling` is more complicated, as we need to check that the any characters in the string are upper case. This can lead to a lot of strange looking solutions. If a student has done this (which nearly all do), encourage them to make it clear what it is doing and how it works. This can be done using a comment, using a function with an intent revealing name, or using code (although this is difficult.)

My favourite code for this is `String.toUpper remark == remark && String.any Char.isAlpha remark`, which I think communicates the purpose of the code as well as possible, and doesn't require an additional comment.

The domain concepts should be present in the code.

Nested conditionals should be avoided, and excessive conditionals in general.

### Talking points

Point free style can be easily and sensibly used for some of the functions, so is worth mentioning if the student hasn't done it.

There are two sensible solutions, so it is worth mentioning / discussing the style of solution that the student didn't use.

How much code / how far down the file do I have to read to understand what the code does, and how easy is it to do so? 

How much code / how far down the file do I have to read to understand how the algorithm works, and how easy is it to do so? 