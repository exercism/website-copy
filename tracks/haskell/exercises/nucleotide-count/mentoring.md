# Mentoring

### Reasonable solutions

```haskell
import qualified Data.Map as Map
import           Data.Map (Map)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts s
  | all isNucleotide s = Right (counts `M.union` zeroMap)
  | otherwise          = Left s
  where
    nucleotides = map (read . return) s
    counts = M.fromListWith (+) (zip nucleotides [1,1..])

isNucleotide :: Char -> Bool
isNucleotide = (`elem` "ACGT")

zeroMap :: Map Nucleotide Int
zeroMap = Map.fromList [(A, 0), (C, 0), (G, 0), (T, 0)]
```

This solution handles errors in a guard.

At its core, `Map.fromListWith (+)` produces the result. Beware that *the
order matters* for arguments to `Map.union`, and that `read . return` is
partial and relies on the validation of the `all isNucleotide` guard.

The error message is a little imprecise.

```haskell
import qualified Data.Map as Map
import           Data.Map (Map)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts s
  | all isNucleotide s = Right $ Map.fromList [ (A, count 'A')
                                              , (C, count 'C')
                                              , (G, count 'G')
                                              , (T, count 'T') ]
  | otherwise = Left s
  where count c = length . filter (== c) $ s

isNucleotide :: Char -> Bool
isNucleotide = (`elem` "ACGT")
```

This solution also handles errors in a guard.

```haskell
import qualified Data.Map as Map
import           Data.Map (Map)

import Control.Monad (foldM)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show, Read)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts = foldM incr zeroMap
  where
    incr nmap c
      | isNucleotide c = return (Map.adjust (+1) (read [c]) nmap)
      | otherwise      = Left [c]

isNucleotide :: Char -> Bool
isNucleotide = (`elem` "ACGT")

zeroMap :: Map Nucleotide Int
zeroMap = Map.fromList [(A, 0), (C, 0), (G, 0), (T, 0)]
```

This solution uses monadic error handling via `foldM`.

The conversion happens with a combination of the guard `isNucleotide`, the
additional `Read` instance, and the partial (unsafe) `read [c]`.  A drawback
with this solution, besides `read` being unsafe, is that `incr` performs
both error handling and incrementing, making it less simple.

```haskell
import           Control.Monad (foldM)
import qualified Data.Map as Map
import           Data.Map (Map)
import           Data.Semigroup ((<>))
import           Text.Read (readEither)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts = foldM (\nmap c -> toNucleotide c >>= incr nmap) zeroMap
  where incr nmap n = return (Map.adjust (+1) n nmap)

toNucleotide :: Char -> Either String Nucleotide
toNucleotide c = readEither [c] <> Left [c]

zeroMap :: Map Nucleotide Int
zeroMap = Map.fromList [(A, 0), (C, 0), (G, 0), (T, 0)]
```

This solution also uses monadic error handling in combination with `foldM`,
but the error handling has been separated from the `incr` function. It uses
the `Read` instance and `readEither` for safe conversion without needing a
separate definition of what a valid nucleotide is.

```haskell
{-# LANGUAGE TupleSections #-}
module DNA (nucleotideCounts, Nucleotide(..)) where

import qualified Data.Map as Map
import           Data.Map (Map)
import           Text.Read (readEither)

data Nucleotide = A | C | G | T
  deriving (Eq, Ord, Enum, Bounded, Show, Read)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts = fmap frequencies . mapM toNucleotide

frequencies :: [Nucleotide] -> Map Nucleotide Int
frequencies = (`Map.union` zeroMap) . Map.fromListWith (+) . (`zip` [1,1..])

toNucleotide :: Char -> Either String Nucleotide
toNucleotide c = readEither [c] <> Left [c]

zeroMap :: Map Nucleotide Int
zeroMap = Map.fromList $ fmap (,0) [minBound..]
```

This solution also uses monadic error handling, but via `mapM toNucleotide`,
separating error handling into a separate step.  It counts the frequency of
each element in the validated input using `Map.fromListWith (+)` and pads the
result with zeroes for elements that were not found once.

The `Enum` and `Bounded` instances along with `[minBound..]` are used to
create a `Map` of zero entries without having to re-list the nucleotides
from the data type definition.

```haskell
{-# LANGUAGE TupleSections #-}
module DNA (nucleotideCounts, Nucleotide(..)) where

import qualified Data.Map as Map
import           Data.Map (Map)
import           Data.Monoid (Sum(..))
import           Text.Read (readEither)

data Nucleotide = A | C | G | T
  deriving (Eq, Ord, Show, Read, Enum, Bounded)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts = fmap frequencies . traverse toNucleotide

toNucleotide :: Char -> Either String Nucleotide
toNucleotide c = readEither [c] <> Left [c]

frequencies :: [Nucleotide] -> Map Nucleotide Int
frequencies = fmap getSum . (<> zeroMap) . frequencies'
  where
    frequencies' :: [Nucleotide] -> Map Nucleotide (Sum Int)
    frequencies' = Map.unionsWith (<>) . fmap (`Map.singleton` 1)

    zeroMap :: Map Nucleotide (Sum Int)
    zeroMap = Map.fromList $ fmap (,mempty) [minBound..]
```

This solution uses the `Sum` monoid and `Map.unionsWith (<>)` instead of
`Map.fromListWith (+)`. Here `mempty = Sum 0`. This is mostly an example of
how one can explore monoids.

```haskell
{-# LANGUAGE TupleSections #-}
module DNA (nucleotideCounts, Nucleotide(..)) where

import qualified Data.Map as Map
import           Data.Map (Map)
import           Data.Validation (Validation, fromEither)
import           Text.Read (readEither)

data Nucleotide = A | C | G | T
  deriving (Eq, Ord, Show, Read, Enum, Bounded)

nucleotideCounts :: String -> Validation String (Map Nucleotide Int)
nucleotideCounts = fmap frequencies . traverse toNucleotide

toNucleotide :: Char -> Validation String Nucleotide
toNucleotide c = fromEither $ readEither [c] <> Left [c]

frequencies :: [Nucleotide] -> Map Nucleotide Int
frequencies = (`Map.union` zeroMap) . Map.fromListWith (+) . (`zip` [1,1..])

zeroMap :: Map Nucleotide Int
zeroMap = Map.fromList $ map (,0) [minBound..]
```

This solution uses the [`validation`][validation] package's `Validation`, a
data type like `Either` but with an accumulating `Applicative`. It is
comparable to `Errors` in the module `Control.Applicative.Lift` of package
[`transformers`][transformers].

This sample solution is not compatible with the test suite because it
mentions `Right` instead of `Success`, but demonstrates how gathering all
errors rather than just the first is possible by simply changing the type.

It also necessitates the use of `traverse` rather than `mapM` since
`Validation` cannot be a `Monad`.

[validation]: http://hackage.haskell.org/package/validation/docs/Data-Validation.html
[transformers]: https://hackage.haskell.org/package/transformers/docs/Control-Applicative-Lift.html

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
- Using a more specialised combinator such as a *map*, `Map.fromList` or
  `Map.fromListWith (+)` conveys more information about the intent of the
  recursion and is thus more declarative.
