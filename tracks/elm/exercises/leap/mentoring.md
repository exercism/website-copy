# Mentoring

This is a good exercise to discuss the describability of logic, as most students solve the problem using a conditional statement that is hard to describe in language, and there are other options.

This exercise introduces `Basics.remainderBy`, the `let` / `in` syntax and partial application / currying.

### Reasonable solutions

The easiest / most common solution probably involves partially applying `Basics.remainderBy` and using a slightly complicated if statement:

```elm
isLeapYear : Int -> Bool
isLeapYear year =
    let
        divisibleBy number = 
            Basics.remainderBy number year == 0         
    in
        divisibleBy 4 && (not (divisibleBy 100) || divisibleBy 400)
```

The complicated if statement is a bit of a problem, as it is hard to describe in language, and hence talking about the code with others is difficult.

Using a case statement turns the if statement in to something like a truth table, and is probably a bit clearer, but at the expense of some extra code. Such solutions are still not ideal, because the chunks of True's and False's are separated from their source, so you have to move your eyes back and forth between the table and the "table header".

```elm
isLeapYear : Int -> Bool
isLeapYear year =
    let
        divisibleBy number = 
            Basics.remainderBy number year == 0         
    in
		case ( divisibleBy 4, divisibleBy 100, divisibleBy 400 ) of
			( True, True, True ) ->
				True

			( True, True, False ) ->
				False

			( True, False, False ) ->
				True

			_ ->
				False
```

If you think about the easiest way to describe the logic to somebody else, you probably come up with a solution like this:

```elm
isLeapYear : Int -> Bool
isLeapYear year =
    let
        divisibleBy number = 
            Basics.remainderBy number year == 0         
    in
		if divisibleBy 400 then
			True

		else if divisibleBy 100 then
			False

		else if divisibleBy 4 then
			True

		else
			False
```

### Common suggestions

Discussing the various options around the describability of the solution is worthwhile. The calculation of leap years is not going to change any time soon, so there is definitely an argument that the complicated conditional statement is ok. However most code deals with business logic, which changes much more frequently, and so the trade off's are different.