module Main where

import Prelude
import BaseRationals (digitsFromArray, fromString, toString)
import Flare (UI, runFlare, string, intRange)
import Data.Either(Either(..))

digitArray =
    ['0', '1', '2', '3', '4', '5', '6', '7','8', '9', 'A', 'B', 'C', 'D', 'E', 'F']

conversion s inputBase outputBase = do
    digits <- digitsFromArray digitArray
    r <- fromString digits inputBase s
    toString digits outputBase r

render :: String -> Int -> Int -> String
render s inputBase outputBase =
    case conversion s inputBase outputBase of
        Left error -> error
        Right string -> string

flare :: forall eff. UI eff String
flare = render <$> string "Input" "0"
               <*> intRange "Input Basis" 2 16 10
               <*> intRange "Output Basis" 2 16 10

main = runFlare "input" "output" flare
