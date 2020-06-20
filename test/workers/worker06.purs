module Test.Workers.Worker06 where

import Prelude

import Effect (Effect)
import Effect.Exception (throwException, error)


-- | Error propagation to parent
main :: Effect Unit
main = throwException (error "patate")
