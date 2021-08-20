module Main where

import Lib ( someFunc, genBoard )


main :: IO ()
main = do
    genBoard 10
    return ()