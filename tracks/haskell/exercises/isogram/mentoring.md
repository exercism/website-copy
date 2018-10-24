### Reasonable solutions

```haskell
import Data.Char (isLetter, toLower)
import qualified Data.Set as Set

isIsogram :: String -> Bool
isIsogram xs = Set.size (Set.fromList [toLower x | x <- xs, isLetter x]) == 26
```

### Common suggestions
- Most solutions seem to start on `nub`, which has notoriously bad performance.
Suggest trying the function on longer strings and then going for a better data
structure than lists for keeping track of the `Set` (hint, hint) of seen
characters.

### Talking points
- How to benchmark solutions, e.g. for telling if `nub` is really slow? Mention
that GHCi can be useful here; it can print basic memory and timing statistics
after entering
```
:set +s
```
...and then trying to check a very long string, e.g.
```
isIsogram (replicate 10000000 'x')
```
