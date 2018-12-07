### Reasonable solutions

```haskell
import qualified Data.Map as M
import           Data.Map (Map)

import Control.Monad (foldM)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show, Read)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts = foldM incr empty
  where
    incr nmap c
      | isNucleotide c = return (M.adjust (+1) (read [c]) nmap)
      | otherwise      = Left $ "Unknown nucleotide " ++ show c

empty :: Map Nucleotide Int
empty = M.fromList [(A, 0), (C, 0), (G, 0), (T, 0)]

isNucleotide :: Char -> Bool
isNucleotide = (`elem` "ACGT")
```

This solution uses monadic error handling via `foldM`.

```haskell
import qualified Data.Map as M
import           Data.Map (Map)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts s
  | any (not . isNucleotide) s = Left $ "Invalid strand " ++ show s
  | otherwise = Right $ M.fromList [ (A, count 'A')
                                   , (C, count 'C')
                                   , (G, count 'G')
                                   , (T, count 'T') ]
  where count c = length . filter (== c) $ s

isNucleotide :: Char -> Bool
isNucleotide = (`elem` "ACGT")
```

This solution handles errors in an initial guard.

Because GHC can fuse list combinators, four separate `length . filter (==
c)` do not necessarily perform bad.

```haskell
import qualified Data.Map as M
import           Data.Map (Map)

import Data.List (foldl')

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show, Read)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts = fmap frequencies . mapM toNucleotide

frequencies :: [Nucleotide] -> Map Nucleotide Int
frequencies = foldl' (\nmap c -> M.insertWith (+) c 1 nmap) empty

toNucleotide :: Char -> Either String Nucleotide
toNucleotide c
  | isNucleotide c = return (read [c])
  | otherwise = Left $ "Unknown nucleotide " ++ show c
```

This solution also uses monadic error handling.

### Common suggestions

- Avoid explicit recursion.
- Use guard-based or monadic error handling.
- Aim for a declarative solution: One that describes the result rather than
  the algorithm.

### Talking points

- Avoid explicit recursion by classifying the recursion scheme.
- Use higher-order combinators for list recursion and error handling.
- Having separate error handling (in guards or in a separate function)
  simplifies the common case.
- There are many ways to update a `Data.Map`: `insertWith`, `adjust`,
  `update`, `alter`, and so on. Depending on the use-case, one may be more
  reasonable than the other. For example, `adjust` makes sense if the
  initial map contains all the keys one wishes to update, and one wishes to
  discard anything else. `insertWith` makes sense when one wishes to gather
  a result for all inputs, which is the case after conversion to
  `Nucleotide`.
