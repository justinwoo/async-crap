module Main where

import qualified Control.Concurrent.Async.Pool as Async
import qualified System.Process as Process

work x = do
  Process.callCommand $ "sleep 1; echo " <> show x

main :: IO ()
main = do
  _ <- Async.withTaskGroup 10 $ \taskgroup ->
    Async.mapTasks taskgroup $ work <$> [1..100]
  putStrLn "done"
