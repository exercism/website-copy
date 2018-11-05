### Reasonable solutions

```haskell
step :: Integer -> Integer
step n
    | even n    = n `rem` 2
    | otherwise = 3 * n + 1

collatz :: Integer -> Maybe Integer
collatz n
    | n > 0     = Just . toInteger . length . takeWhile (/= 1) . iterate step $ n
    | otherwise = Nothing
```

### Common suggestions
Many students seem to come up with solutions in which the concerns of

1. Computing the next Collatz number given some input number.
2. Computing the sequence of all Collatz numbers given some starting value.
3. Truncating the number sequence at the first `1`
4. Counting the number of elements in the truncated sequence.

are intertwined. The result is a single `collatz` definition using manual
recursion. The issue with this is that it's quite hard to read -- in particular,
it's hard to tell whether such a definition is faithful to the instructions.

A approach is to only write custom code for '1.' above and solve the other
three items with standard Haskell functionality: `iterate`, `takeWhile` and
`length`.

### Talking points
- When dividing a number, many students seem to go for `mod` even though `rem`
is a better choice here. This is a good opportunity to discuss the merits of
`quot` and `rem` over `div` and `mod.

- Since `collatz` needs to yield an `Integer` (instead of an `Int`), it's
necessary to somehow convert the value returned by `length` into an `Integer`.
`fromIntegral` is a common solution here. An alternative is to use
`genericLength`.
