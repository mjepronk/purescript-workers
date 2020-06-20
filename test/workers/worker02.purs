module Test.Workers.Worker02 where

import Prelude
import Effect (Effect)

import GlobalScope.Dedicated (postMessage, onMessage, location)


-- | Worker accessing the location in its global scope
main :: Effect Unit
main = onMessage (\_ -> location `bind` postMessage)
