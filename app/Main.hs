module Main where

import Lib ( someFunc, genBoard )


main :: IO ()
main = do
    someFunc
    board <- genBoard 10
    return ()
