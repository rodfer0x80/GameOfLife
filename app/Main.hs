module Main where

import Lib (  genBoard
            , totalCells
            , tick
            )


main :: IO ()
main = do
    board <- genBoard totalCells
    tick board
    return ()