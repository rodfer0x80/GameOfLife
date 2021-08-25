module Lib
    ( genBoard
    , totalCells
    , tick
    ) where

import System.Random ( randomRIO )
import Control.Monad ( replicateM )
import Data.List ( intersperse ) 
import Control.Concurrent (threadDelay)
import Data.Foldable (traverse_)

-- Clear the screen
clearScreen :: IO ()
clearScreen = putStr "\ESC[2J"

-- Sleep like implementation
gameSleep :: Int -> IO ()
gameSleep n = sequence_ [return () | _ <- [1..n]]

-- Moves to point (x,y) on screen
screenGoto :: (Int, Int) -> IO ()
screenGoto (x,y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")

-- Cell Status
data Cell = Dead | Alive deriving Eq

instance Show Cell where 
    show Alive = "o"
    show Dead = "."

-- Board square a x a
a :: Int
a = 20

totalCells :: Int
totalCells = a * a

type Board = [Cell]

genPair :: IO Cell
genPair = do
    n <- randomRIO (0, 1) :: IO Int
    let cell =  if n == 1
                    then Alive
                else Dead
    return cell


genBoard :: Int -> IO [Cell]
genBoard n
    = replicateM n genPair

displayBoard :: Show a => [a] -> IO ()
displayBoard [] = putStrLn ""
displayBoard board = do
                        putStrLn ""
                        traverse_ (putStr . (\ x -> show x ++ " ")) (take a board)
                        displayBoard (drop a board)

-- check for neighbours over each element of the list and create new 
wipe :: [a] -> [Cell]
wipe = map $ const Dead 


-- tagBoard :: [b] -> [(Int, b)]
-- tagBoard  = zip [0 .. totalCells]

-- check neighbours calculates the number of Alive neightbours for each element of the board
-- natural selection changes each element to a new state depending on number neighbours
-- naturalSelection n
--     | n > 3 = Dead
--     | n < 2 = Dead
--     | n 

-- nextGen :: [Cell] -> [Cell]
-- nextGen board = map naturalSelection (map checkNeighbours (tagBoard board)) board

isEmptyBoard ::   [Cell] -> [Cell]
isEmptyBoard = filter (== Alive)

tick :: [Cell] -> IO ()
tick board = do
        screenGoto (1,1)
        clearScreen
        displayBoard board
        threadDelay 1000000

        if not $ null $ isEmptyBoard board
        then
            tick $ wipe board
         else
            do 
               clearScreen
               screenGoto (1,1)
               putStrLn "Game Over!"

