module Main where

import Lib ( someFunc, genBoard )


main :: IO ()
main = do
    someFunc
    board <- genBoard 10
    putStrLn $ show $ map fst board
    putStrLn $ show $ map snd board
    putStrLn $ show $ map (\(x,y) -> (x,y)) board
    return ()
