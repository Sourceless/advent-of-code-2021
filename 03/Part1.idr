module Part1

import System.File
import Data.String
import Data.Maybe
import Data.List
import Data.Nat


toBit : Char -> Nat
toBit '0' = 0
toBit '1' = 1
toBit _ = 1 -- Hack

toBinary : String -> List Nat
toBinary = map toBit . unpack

bitTotals : String -> List Nat
bitTotals = map sum . transpose . (map toBinary) . lines

partial -- :( sad but I don't want to spend any more time on this
mostCommonBit : Nat -> Nat -> Nat
mostCommonBit totalEntries howMany =
  if (lt howMany (divNat totalEntries 2))
    then 1
    else 0
  -- if (lt howMany (divNat totalEntries 2)))
  --   then 1
  --   else 0

invert : Nat -> Nat
invert 0 = 1
invert _ = 0 -- HACK

binToNat' : List Nat -> Nat -> Nat -> Nat
binToNat' [] _ sum = sum
binToNat' (bit::bits) exponent sum = binToNat' bits (exponent * 2) (sum + (bit * exponent))

binToNat : List Nat -> Nat
binToNat bits = binToNat' (reverse bits) 1 0

partial
diagnose : String -> IO ()
diagnose s = let totals = bitTotals s;
                 numLines = length (lines s);
                 mcbs = map (mostCommonBit numLines) totals
                 lcbs = map invert mcbs in
               printLn ((binToNat mcbs) * (binToNat lcbs))

partial
main : IO ()
main = do file <- readFile "input.txt"
          case file of
               Right content => diagnose content
               Left err => printLn err
