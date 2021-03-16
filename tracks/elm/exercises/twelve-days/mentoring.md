# Mentoring


This is a good exercise to talk about naming, as it is quite difficult and most students struggle with it.

This exercise introduces some List handling functions, such as `List.map`, `List.range`, `List.take` and `List.reverse`, and some string handling functions, such as `++` and `String.join`.

Students should strive to communicate what the code does in as few lines as possible (ideally you should be able to understand what is it trying to do in the entry function). They show also strive to communicate how it does it in as few lines as possible.

## Reasonable solutions

Only listing out the complete text of all verses is the most straight-forward solution, and is a reasonable initial choice in real life. Then, if changes are required to the song, it makes sense to refactor to remove the duplication, and then make the changes. However this solution doesn't really help the student learn elm, so if they have done this encourage them to make a further iteration.

All solutions need a way of turning an `Int` into a string ordinal, and into a `string` describing the gift for a day. `Dict.fromList`, `Array.fromList`, `List` or `case statements` are normal ways to do this, and are equally favourable.

It is generally best to iterate over the verses using `List.map` or similar. It is possible to use recursion, but it makes naming harder, and is more complex than it needs to be.

It is possible to use a type (like the one below) to contain all the information for a day (the ordinal and the gift for the day). This keeps the ordinal and gift strings closer together, which is good, but adds some noise, which is bad.

```elm
type alias NthDay =
    { nthDay : Int
	, ordinal : String
    , gift : String
    }
```

["Ceddlyburge" has a example solution](https://exercism.io/tracks/elm/exercises/twelve-days/solutions/7b614615e44f4ea6b6a0aa1b919054de) that uses case statements.
	
## Common suggestions

Naming is difficult, especially in this exercise, and most students often do not choose good names. Generally a good rule is to have the name be one-level-of-abstraction-up from what the code does, so that it still conveys a somewhat concrete meaning, but the implementation can change without having to change the name. `onTheNthDay` and `whatWasGiven` are reasonable choices for commonly used functions. `onTheNthDay` doesn't mention Christmas, so would allow the code to be changed for a different event ('on the first day of easter ...') and still make sense, while still being meaningful enough to be useful. 'onTheNth' is also possible, which would allow the code to change to 'on the second year of the new millenium' without having to change the name, and again the name is still meaningful enough to be useful.

A lot of students struggle to concatenate the verses without a lot of special case code and conditionals. Most of this can be avoided by adding `,` and `, and` to the gift strings.

## Talking points

In the real world, the entry function would probably return a `Maybe` or a `Result` to indicate that it can fail / can recieve invalid input. However, this function already defined by the exercise without this (I think to keep the exercise relatively simple). This means that we have to make choices about what to do with out of bounds inputs. Using `clamp` or similar is one possibility, to transform out of range inputs in to in range ones. The other options are to return nonsensical output, or explicit error output. 

How much code / how far down the file do I have to read to understand what the code does, and how easy is it to do so? 

How much code / how far down the file do I have to read to understand how the algorithm works, and how easy is it to do so? 
