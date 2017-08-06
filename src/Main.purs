module Main where

import Prelude

import Flare as Flare

import Data.Either(Either(..))
import BaseRationals (digitsFromArray, fromString, toString)


digitArray :: Array Char
digitArray = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F']

conversion :: String -> Int -> Int -> Either String String
conversion inString inBase outBase = do
    digits <- digitsFromArray digitArray
    ratio <- fromString digits inBase inString
    toString digits outBase ratio

render :: String -> Int -> Int -> String
render inString inBase outBase =
    case conversion inString inBase outBase of
        Left error -> error
        Right string -> string

flare :: forall eff. Flare.UI eff String
flare = render
    <$> Flare.string "Input" "0"
    <*> Flare.intRange "Input Basis" 2 16 10
    <*> Flare.intRange "Output Basis" 2 16 10


main :: _
main = Flare.runFlare "input" "output" flare
