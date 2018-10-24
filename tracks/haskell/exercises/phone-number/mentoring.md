### Reasonable solutions

```haskell
import Data.Char (isDigit)

number :: String -> Maybe String
number xs = case filter isDigit xs of
    ns@[     n,_,_, n',_,_, _,_,_,_] | all (> '1') [n, n'] -> Just ns
    ns@['1', n,_,_, n',_,_, _,_,_,_] | all (> '1') [n, n'] -> Just (tail ns)
    _                                                      -> Nothing
```

### Common suggestions
- Most submissions attempt to parse the input string, but Haskell's pattern
matching can be put to good use here!
