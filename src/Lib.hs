module Lib
    ( someFunc
    , genBoard
    , totalCells
    , displayBoard
    ) where

import System.Random ( randomRIO )
import Control.Monad ( replicateM )
import GHC.Show (Show)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- Clear the screen
clearScreen :: IO ()
clearScreen = putStr "\ESC[2J"

-- Sleep like implementation
gameSleep :: Int -> IO ()
gameSleep n = sequence_ [return () | _ <- [1..n]]

-- Moves to point (x,y) on screen
--screenGoto :: Point -> IO ()
--screenGoto (x,y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")



-- Cell Position Point(x,y)
type Point = (IO Int, IO Int)

-- Cell Status
data Cell = Dead | Alive

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


--formatBoard = -- for each  1 element in list intercalate with a space, for each 20(a) intercalate with a newline
-- then do displayBoard(formatBoard board)
-- so this takes a board and returns a board / list modified

-- take a elements and print to screen; then
displayBoard :: Show b => [b] -> IO [()]
displayBoard = traverse $ putStr . show


{--
tick :: Board -> IO ()
tick board = if not (isBoardEmpty board) then
            do clearScreen
               displayBoard b
               gameSleep 500000
               tick (nextGen board)
         else
            do clearScreen
               screenGoto (1,1)
               putStrLn "Game Over !"
--}



