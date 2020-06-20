module MessagePort
  -- * Types
  ( MessagePort

  -- * Interaction with MessagePort-like types
  , onMessage
  , onMessageError

  -- * MessagePort specific manipulations
  , close
  , start
  )
where

import Prelude

import Effect (Effect)
import Effect.Exception (Error)

import Workers.Class (class Channel)


-- | Event handler for the `message` event
onMessage :: forall msg. MessagePort -> (msg -> Effect Unit) -> Effect Unit
onMessage port = _onMessage port

-- | Event handler for the `messageError` event
onMessageError :: MessagePort -> (Error -> Effect Unit) -> Effect Unit
onMessageError port = _onMessageError port

-- | TODO DOC
close :: MessagePort -> Effect Unit
close = _close

-- | TODO DOC
start :: MessagePort -> Effect Unit
start = _start


foreign import data MessagePort :: Type

instance channelMessagePort :: Channel MessagePort


foreign import _onMessage :: forall msg. MessagePort -> (msg -> Effect Unit) -> Effect Unit

foreign import _onMessageError :: MessagePort -> (Error -> Effect Unit) -> Effect Unit

foreign import _close :: MessagePort -> Effect Unit

foreign import _start :: MessagePort -> Effect Unit
