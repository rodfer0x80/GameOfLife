module Main where

import Lib ( someFunc, genBoard, totalCells, displayBoard )


main :: IO ()
main = do
    someFunc
    board <- genBoard totalCells
    displayBoard board
    --putStrLn $ show $ map (\x -> x) board
    return ()
