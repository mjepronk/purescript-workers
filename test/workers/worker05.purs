module Test.Workers.Worker05 where

import Prelude
import Effect (Effect)
import Effect.Exception (throwException, error, name)

import GlobalScope.Dedicated (onError, postMessage)


-- | Exception handling via onError
main :: Effect Unit
main = do
  onError (name >>> postMessage)
  throwException (error "patate")
