# Mentoring

## Reasonable solutions

```haskell
import Data.Char (toLower)

isPangram :: String -> Bool
isPangram s = all (`elem` map toLower s) ['a'..'z']
```

This solution traverses the input once for each letter, but terminates once each was found.

It has the benefit of being declarative and to some extent short-circuiting.

```haskell
import Data.Char (toLower)

isPangram :: String -> Bool
isPangram s = null (['a'..'z'] \\ map toLower s)
```

This solution traverses the input at most once and terminates once each is found.

It has the benefit of being efficient, declarative and set-based (although not `Data.Set`-based).

```haskell
import Data.Char (toLower)
import Data.Set (fromList, delete)

alphabet :: Set Char
alphabet = fromList ['a'..'z']

isPangram :: String -> Bool
isPangram = any null . scanl deleteLower alphabet
  where deleteLower cs c = delete (toLower c) cs
```

This solution traverses the input at most once and terminates once each is found.

## Common suggestions

- Instead of `"abc...xyz"`, one can just write `['a'..'z']`.
- Some solutions use `nub`. This is never necessary. It is better to use `Data.Set` here.
- Some solutions `map head . group . sort`; this is also not necessary. Use `Data.Set`.
- Avoid manual recursion in favor of `any`, `scanl` or set-based operators.
- Instead of doing `Set.fromList` and then `Set.map`, it's preferred to stick with list and convert to `Set` in last step.

## Talking points

- Consider non-strictness and the number of iterations over the input.
- Consider efficient data types (lists vs. sets).
- Consider making a *declarative* solution, i.e. one that describes the result rather than the method of finding it.
- Mention about `Set.fromDistinctAscList ['a'..'z']` if student's solution is `Set`-based. Make sure to mention that input is unchecked so this has to be careful.
