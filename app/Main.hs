module Main where

import Lib ( someFunc, genBoard )


main :: IO ()
main = do
    board <- genBoard 10
    return ()