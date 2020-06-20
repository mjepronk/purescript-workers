module Test.Workers.Worker09 where

import Prelude

import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Aff (launchAff_)
import Data.String (toUpper)
import Data.Traversable (traverse_)

import Workers (postMessage)
import GlobalScope.Service (ClientId, clients, claim, matchAll, onActivate, onMessage)


main :: Effect Unit
main = do
  onMessage  onMessageHandler
  onActivate onActivateHandler


onMessageHandler :: ClientId -> String -> Effect Unit
onMessageHandler _ msg =
  clients
  >>= \cs -> launchAff_ $ matchAll cs
  >>= traverse_ (\client -> liftEffect $ postMessage client (toUpper msg))


onActivateHandler :: Effect Unit
onActivateHandler = clients >>= \cs -> launchAff_ (claim cs)
