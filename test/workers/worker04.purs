module Test.Workers.Worker04 where

import Prelude

import Effect (Effect)
import Data.NonEmpty (head)

import GlobalScope.Shared (onConnect)
import Workers.Shared (postMessage)


-- | Shared Worker working through a port
main :: Effect Unit
main = onConnect $ \ports -> postMessage (head ports) true
