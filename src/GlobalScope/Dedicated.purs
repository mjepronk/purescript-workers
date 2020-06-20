module GlobalScope.Dedicated
  ( name
  , postMessage
  , postMessage'
  , onMessage
  , onMessageError
  , module GlobalScope
  )
where

import Prelude

import Effect (Effect)
import Effect.Exception (Error)

import GlobalScope (close, location, navigator, onError, onLanguageChange,
    onOffline, onOnline, onRejectionHandled, onUnhandledRejection)


-- | Clones message and transmits it to the Worker object.
postMessage :: forall msg .  msg -> Effect Unit
postMessage msg = _postMessage msg []


-- | Clones message and transmits it to the Worker object associated with
-- | dedicatedWorkerGlobal.transfer can be passed as a list of objects that are
-- | to be transferred rather than cloned.
postMessage' :: forall msg transfer.  msg -> Array transfer -> Effect Unit
postMessage' = _postMessage


-- | Returns dedicatedWorkerGlobal’s name, i.e. the value given to the Worker
-- | constructor. Primarily useful for debugging.
foreign import name :: Effect String

foreign import _postMessage :: forall msg transfer.  msg -> Array transfer -> Effect Unit

-- | Event handler for the `message` event
foreign import onMessage :: forall msg. (msg -> Effect Unit) -> Effect Unit

-- | Event handler for the `messageError` event
foreign import onMessageError :: (Error -> Effect Unit) -> Effect Unit
