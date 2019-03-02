module Main where

import qualified System.Process as Process
import qualified Control.Concurrent.Async as Async

work x = do
  Process.callCommand $ "sleep 1; echo " <> show x

doWork [] = pure ()
doWork xs = do
  Async.mapConcurrently_ work $ take 5 xs
  doWork $ drop 5 xs

main :: IO ()
main = do
  doWork [1..100]
