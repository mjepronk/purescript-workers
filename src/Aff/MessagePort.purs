module Aff.MessagePort
  ( onMessage
  , onMessageError
  , close
  , start
  , module MessagePort
  )
where

import Prelude

import Effect.Aff (Aff)
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Exception (Error)

import MessagePort as MP
import MessagePort (MessagePort)


-- | Event handler for the `message` event
onMessage :: forall msg .  MessagePort -> (msg -> Effect Unit) -> Aff Unit
onMessage p = liftEffect <<< MP.onMessage p

-- | Event handler for the `messageError` event
onMessageError :: MessagePort -> (Error -> Effect Unit) -> Aff Unit
onMessageError p = liftEffect <<< MP.onMessageError p

-- | TODO DOC
close :: MessagePort -> Aff Unit
close = liftEffect <<< MP.close

-- | TODO DOC
start :: MessagePort -> Aff Unit
start = liftEffect <<< MP.start
