### Reasonable solutions

```haskell
import qualified Data.Map as M
import           Data.Map (Map)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts s
  | all isNucleotide s = Right (counts `M.union` empty)
  | otherwise          = Left s
  where
    nucleotides = map (read . return) s
    counts = M.fromListWith (+) (zip nucleotides [1,1..])

isNucleotide :: Char -> Bool
isNucleotide = (`elem` "ACGT")

empty :: Map Nucleotide Int
empty = M.fromList [(A, 0), (C, 0), (G, 0), (T, 0)]
```

This solution handles errors in an initial guard.

At its core, `M.fromListWith (+)` produces the result. Beware that *the
order matters* for arguments to `M.union`, and that `read . return` is
partial and relies on the validation of the `all isNucleotide` guard.

The error message is a little imprecise.

```haskell
import qualified Data.Map as M
import           Data.Map (Map)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts s
  | all isNucleotide s = Right $ M.fromList [ (A, count 'A')
                                            , (C, count 'C')
                                            , (G, count 'G')
                                            , (T, count 'T') ]
  | otherwise = Left $ "Invalid strand " ++ show s
  where count c = length . filter (== c) $ s

isNucleotide :: Char -> Bool
isNucleotide = (`elem` "ACGT")
```

This solution also handles errors in an initial guard.

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

isNucleotide :: Char -> Bool
isNucleotide = (`elem` "ACGT")

empty :: Map Nucleotide Int
empty = M.fromList [(A, 0), (C, 0), (G, 0), (T, 0)]
```

This solution uses monadic error handling via `foldM`.

The conversion happens with a combination of the guard `isNucleotide`, the
additional `Read` instance, and the partial (unsafe) `read [c]`.

Another drawback with this solution is that `incr` performs both error
handling and the increment making it less simple.

```haskell
import qualified Data.Map as M
import           Data.Map (Map)

import Control.Monad (foldM)
import Data.Semigroup ((<>))
import Text.Read (readEither)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts = foldM (\nmap c -> toNucleotide c >>= incr nmap) empty
  where incr nmap n = return (M.adjust (+1) n nmap)

toNucleotide :: Char -> Either String Nucleotide
toNucleotide c = readEither [c] <> Left ("Unknown nucleotide " ++ show c)
```

This solution also uses monadic error handling in combination with `foldM`,
but the error handling has been separated from the `incr` function. It uses
the `Read` instance and `readEither` for safe conversion without needing a
separate definition of what a valid nucleotide is.

```haskell
import qualified Data.Map as M
import           Data.Map (Map)

import Control.Monad (mapM)
import Data.Semigroup ((<>))
import Text.Read (readEither)

data Nucleotide = A | C | G | T
                deriving (Eq, Ord, Show, Read, Enum, Bounded)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts = fmap (fillZeroes . frequencies) . mapM toNucleotide

frequencies :: [Nucleotide] -> Map Nucleotide Int
frequencies ns = M.fromListWith (+) (zip ns [1,1..])

toNucleotide :: Char -> Either String Nucleotide
toNucleotide c = readEither [c] <> Left ("Unknown nucleotide " ++ show c)

fillZeroes :: Map Nucleotide Int -> Map Nucleotide Int
fillZeroes = (`M.union` empty)

empty :: Map Nucleotide Int
empty = M.fromListWith (+) (zip [minBound..] [0,0..]))
```

This solution also uses monadic error handling, but via `mapM toNucleotide`,
thus separating error handling into a separate step.  It counts the
frequency of each element in the validated input using `M.fromListWith (+)`
and pads the result with zeroes for elements that were not found once.

The `Enum` and `Bounded` instances along with `zip [minBound..]` are used to
create an empty `Map` without having to re-list the nucleotides from the
data type definition.

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
- Using a more specialised combinator such as a *map*, `M.fromList` or
  `M.fromListWith (+)` conveys more information about the intent of the
  recursion and is thus more declarative.
