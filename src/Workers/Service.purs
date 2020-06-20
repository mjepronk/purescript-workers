module Workers.Service
  -- * Constructors & Setup
  ( Registration
  , RegistrationOptions
  , controller
  , getRegistration
  , onControllerChange
  , onMessage
  , ready
  , register
  , register'
  , startMessages
  , wait

  -- * Service Worker Manipulations
  , State(..)
  , Service
  , onStateChange
  , scriptURL
  , state

  -- * Registration Manipulations
  , active
  , installing
  , waiting
  , scope
  , update
  , unregister
  , onUpdateFound

  -- * Re-exports
  , module Workers
  )
where

import Prelude

import Effect.Aff (Aff, delay)
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toMaybe, toNullable)
import Data.String.Read (class Read, read)
import Data.Time.Duration (Milliseconds(Milliseconds))

import Workers (WorkerType(..), onError, postMessage, postMessage')
import Workers.Class (class AbstractWorker, class Channel)


foreign import data Service :: Type

instance abstractWorkerService :: AbstractWorker Service

instance channelService :: Channel Service


foreign import data Registration :: Type


type RegistrationOptions =
  { scope      :: String
  , workerType :: WorkerType
  }


data State
  = Installing
  | Installed
  | Activating
  | Activated
  | Redundant

instance showState :: Show State where
  show s =
    case s of
      Installing -> "installing"
      Installed  -> "installed"
      Activating -> "activating"
      Activated  -> "activated"
      Redundant  -> "redundant"

instance readState :: Read State where
  read s =
    case s of
      "installing" -> pure Installing
      "installed"  -> pure Installed
      "activating" -> pure Activating
      "activated"  -> pure Activated
      "redundant"  -> pure Redundant
      _            -> Nothing


-- SERVICE WORKER CONTAINER ~ navigator.serviceWorker globals

controller :: Effect (Maybe Service)
controller = toMaybe <$> _controller

getRegistration :: Maybe String -> Aff (Maybe Registration)
getRegistration = toNullable >>> _getRegistration >=> toMaybe >>> pure

onControllerChange :: Effect Unit -> Effect Unit
onControllerChange = _onControllerChange

onMessage :: forall msg. (msg -> Effect Unit) -> Effect Unit
onMessage = _onMessage

ready :: Aff Registration
ready = _ready

register :: String -> Aff Registration
register url = fromEffectFnAff $ _register url
    { scope: ""
    , workerType: Classic
    }

register' :: String -> RegistrationOptions -> Aff Registration
register' s ro = fromEffectFnAff $ _register s ro

startMessages :: Effect Unit
startMessages = _startMessages

wait :: Aff Service
wait = do
  mworker <- liftEffect controller
  case mworker of
    Nothing -> do
      delay (Milliseconds 50.0)
      wait
    Just worker -> do
      pure worker


-- ServiceWorker instance methods

onStateChange :: Service -> (State -> Effect Unit) -> Effect Unit
onStateChange = _onStateChange (read >>> toNullable)

scriptURL :: Service -> String
scriptURL = _scriptURL

state :: Service -> State
state = _state (read >>> toNullable)


-- ServiceWorkerRegistration instance methods

active :: Registration -> Maybe Service
active = _active >>> toMaybe

installing :: Registration -> Maybe Service
installing = _installing >>> toMaybe

waiting :: Registration -> Maybe Service
waiting = _waiting >>> toMaybe

scope :: Registration -> String
scope = _scope

update :: Registration -> Aff Unit
update = _update

unregister :: Registration -> Aff Boolean
unregister = _unregister

onUpdateFound :: Registration -> Effect Unit -> Effect Unit
onUpdateFound = _onUpdateFound



foreign import _controller :: Effect (Nullable Service)

foreign import _getRegistration :: Nullable String -> Aff (Nullable Registration)

foreign import _onControllerChange :: Effect Unit -> Effect Unit

foreign import _onMessage :: forall msg. (msg -> Effect Unit) -> Effect Unit

foreign import _ready :: Aff Registration

foreign import _register :: String -> RegistrationOptions -> EffectFnAff Registration

foreign import _startMessages :: Effect Unit

foreign import _onStateChange
  :: (String -> Nullable State)
  -> Service
  -> (State -> Effect Unit)
  -> Effect Unit

foreign import _scriptURL :: Service -> String

foreign import _state :: (String -> Nullable State) -> Service -> State

foreign import _active :: Registration -> Nullable Service

foreign import _installing :: Registration -> Nullable Service

foreign import _waiting :: Registration -> Nullable Service

foreign import _scope :: Registration -> String

foreign import _update :: Registration -> Aff Unit

foreign import _unregister :: Registration -> Aff Boolean

foreign import _onUpdateFound :: Registration -> Effect Unit -> Effect Unit
