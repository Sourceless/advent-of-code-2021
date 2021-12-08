module Part2

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

-- HACK -- I'm still not quite sure how to prove that a value is non empty :(
mostSignificantBit : List Nat -> Nat
mostSignificantBit [] = 0
mostSignificantBit (x::xs) = x

hasFirstBit : Nat -> List Nat -> Bool
hasFirstBit _ [] = False
hasFirstBit check (firstBit::_) = firstBit == check

-- HACK: I really need to learn this proof system, this is not sustainable...
pleaseGetTheLastOne : List (List Nat) -> List Nat
pleaseGetTheLastOne [] = [0]
pleaseGetTheLastOne [x] = x
pleaseGetTheLastOne (_::xs) = pleaseGetTheLastOne xs

-- HACK: yeah this is falling the fuck apart... time to hit the books
partial
filterCandidates : List (List Nat) -> List Nat -> List Nat
filterCandidates _ [] = []
filterCandidates [] _ = []
filterCandidates [x] _ = x
filterCandidates allNums (msb::bs) =
  let candidates = filter (hasFirstBit msb) allNums
      innerCandidates = filterCandidates candidates bs in
      if innerCandidates == []
        then (pleaseGetTheLastOne candidates)
        else innerCandidates

partial
diagnose : String -> IO ()
diagnose s = let allNums = map toBinary (lines s)
                 totals = bitTotals s
                 numLines = length (lines s)
                 mcbs = map (mostCommonBit numLines) totals
                 lcbs = map invert mcbs
                 oxygenCandidates = filterCandidates allNums mcbs
                 co2Candidates = filterCandidates allNums lcbs in
               printLn oxygenCandidates

partial
main : IO ()
main = do file <- readFile "input.txt"
          case file of
               Right content => diagnose content
               Left err => printLn err
