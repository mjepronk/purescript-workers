module Test.Workers.Worker03 where

import Prelude
import Effect (Effect)

import GlobalScope.Dedicated (onMessage, postMessage, navigator)


-- | Worker accessing the navigator in its global scope
main :: Effect Unit
main = onMessage (\_ -> navigator `bind` postMessage)
