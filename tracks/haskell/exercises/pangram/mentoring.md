### Reasonable solutions

```haskell
import Data.Char (toLower)

isPangram :: String -> Bool
isPangram xs = all (`elem` map toLower xs) ['a'..'z']
```

```haskell
import Data.Char (toLower)

isPangram :: String -> Bool
isPangram xs = null (['a'..'z'] \\ map toLower xs)
```

### Common suggestions
- Instead of writing out all letters in the alphabet, it's possible to take
advantage of the `Enum Char` instance, i.e. instead of "abcdefghijk...xyz", one
can just write `['a'..'z']`.

### Talking points
