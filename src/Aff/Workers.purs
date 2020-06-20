module Aff.Workers
  ( onError
  , postMessage
  , postMessage'
  , module Workers
  )
where

import Prelude

import Effect.Aff (Aff)
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Exception (Error)

import Workers as W
import Workers (Location(..), Navigator(..), Options, WorkerType(..), Credentials(..))
import Workers.Class (class AbstractWorker, class Channel)


-- | Event handler for the `error` event.
onError :: forall worker. (AbstractWorker worker) => worker -> (Error -> Effect Unit) -> Aff Unit
onError w = liftEffect <<< W.onError w

-- | Clones message and transmits it to the Worker object.
postMessage :: forall msg channel. (Channel channel) => channel -> msg -> Aff Unit
postMessage p = liftEffect <<< W.postMessage p

-- | Clones message and transmits it to the port object associated with
-- | dedicatedportGlobal.transfer can be passed as a list of objects that are to be
-- | transferred rather than cloned.
postMessage'
  :: forall msg transfer channel. (Channel channel)
  => channel
  -> msg
  -> Array transfer
  -> Aff Unit
postMessage' p m = liftEffect <<< W.postMessage' p m
