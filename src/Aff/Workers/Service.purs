module Aff.Workers.Service
  ( controller
  , getRegistration
  , onControllerChange
  , onMessage
  , ready
  , register
  , register'
  , startMessages
  , wait
  , onStateChange
  , scriptURL
  , state
  , active
  , installing
  , waiting
  , scope
  , update
  , unregister
  , onUpdateFound
  , module Workers.Service
  , module Aff.Workers
  )
where

import Prelude

import Effect.Aff (Aff)
import Effect (Effect)
import Effect.Class (liftEffect)
import Data.Maybe (Maybe)

import Aff.Workers (WorkerType(..), onError, postMessage, postMessage')
import Workers.Service (Service, Registration, RegistrationOptions, State(..))
import Workers.Service as W


-- SERVICE WORKER CONTAINER ~ navigator.serviceWorker globals

controller :: Aff (Maybe Service)
controller = liftEffect W.controller

getRegistration :: Maybe String -> Aff (Maybe Registration)
getRegistration = W.getRegistration

onControllerChange :: Effect Unit -> Effect Unit
onControllerChange = W.onControllerChange

onMessage :: forall msg. (msg -> Effect Unit) -> Effect Unit
onMessage = W.onMessage

ready :: Aff Registration
ready = W.ready

register :: String -> Aff Registration
register = W.register

register' :: String -> RegistrationOptions -> Aff Registration
register' = W.register'

startMessages :: Aff Unit
startMessages = liftEffect W.startMessages

wait :: Aff Service
wait = W.wait


-- SERVICE WORKER ~ instance methods

onStateChange :: Service -> (State -> Effect Unit) -> Aff Unit
onStateChange service = liftEffect <<< W.onStateChange service

scriptURL :: Service -> String
scriptURL = W.scriptURL

state :: Service -> State
state = W.state


-- SERVICE WORKER REGISTRATION ~ instance method

active :: Registration -> Maybe Service
active = W.active

installing :: Registration -> Maybe Service
installing = W.installing

waiting :: Registration -> Maybe Service
waiting = W.waiting

scope :: Registration -> String
scope = W.scope

update :: Registration -> Aff Unit
update = W.update

unregister :: Registration -> Aff Boolean
unregister = W.unregister

onUpdateFound :: Registration -> Effect Unit -> Aff Unit
onUpdateFound registration = liftEffect <<< W.onUpdateFound registration
