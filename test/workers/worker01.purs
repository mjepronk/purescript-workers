module Test.Workers.Worker01 where

import Prelude
import Effect (Effect)

import GlobalScope.Dedicated (onMessage, postMessage)


-- | Basic Worker Replying "world" to any message
main :: Effect Unit
main = onMessage (\_ -> postMessage "world")
