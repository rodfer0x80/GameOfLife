module Lib
    ( someFunc
    ) where

import System.Random ( randomRIO )
import Control.Monad (replicateM)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- Clear the screen
clearScreen :: IO ()
clearScreen = putStr "\ESC[2J"

-- Sleep like implementation
gameSleep :: Int -> IO ()
gameSleep n = sequence_ [return () | _ <- [1..n]]

-- Moves to point (x,y) on screen
screenGoto :: Point -> IO ()
screenGoto (x,y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")



-- Cell Position Point(x,y)
type Point = (IO Int, IO Int)

-- Cell Status
data Cell = Dead | Alive 

-- Board square a x a
a :: Int
a = 100

totalCells :: Int
totalCells = a * a

type Board = [Point]

initBoard :: Int -> Board
initBoard 0 = []
initBoard n 
    = (x, y) : initBoard (n-1)
    where 
        x = randomRIO(0, a)
        y = randomRIO(0, a)


genPair :: IO (Int, Int)
genPair = do
    x <- randomRIO 0 a
    y <- randomRIO 0 a
    return (x,y)


genBoard :: Int -> IO [(Int, Int)]
genBoard n
    = replicateM n genPair


tick :: Board -> IO ()
tick board = if not (isBoardEmpty board) then
            do clearScreen
               displayCells b
               gameSleep 500000
               tick (nextGen board)
         else
            do clearScreen
               screenGoto (1,1)
               putStrLn "Game Over !"




