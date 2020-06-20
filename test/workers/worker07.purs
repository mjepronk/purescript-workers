module Test.Workers.Worker07 where

import Prelude
import Effect (Effect)
import Effect.Exception (name, catchException)

import GlobalScope.Dedicated (postMessage)


-- | Catch Data Clone Errors
main :: Effect Unit
main = (name >>> postMessage) `catchException` postMessage ((+) 1)
