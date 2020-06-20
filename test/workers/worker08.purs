module Test.Workers.Worker08 where

import Prelude
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Aff (launchAff_)
import Data.Maybe (Maybe(..))
import Data.String (toUpper)

import Workers (postMessage)
import GlobalScope.Service (ClientId, clients, claim, get, onActivate, onMessage)


main :: Effect Unit
main = do
  onMessage  onMessageHandler
  onActivate onActivateHandler


onMessageHandler :: ClientId -> String -> Effect Unit
onMessageHandler cid msg =
  clients >>= \cs -> launchAff_ $ get cs cid >>=
    case _ of
      Just client -> liftEffect $ postMessage client (toUpper msg)
      Nothing     -> pure unit


onActivateHandler :: Effect Unit
onActivateHandler = clients >>= \cs -> launchAff_ (claim cs)
