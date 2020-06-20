module Workers
  ( Location(..)
  , Navigator(..)
  , WorkerType(..)
  , Options
  , Credentials(..)
  , onError
  , postMessage
  , postMessage'
  )
where

import Prelude

import Effect (Effect)
import Effect.Exception (Error)
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.String.Read (class Read)

import Workers.Class (class AbstractWorker, class Channel)


newtype Location = Location
  { origin   :: String
  , protocol :: String
  , host     :: String
  , hostname :: String
  , port     :: String
  , pathname :: String
  , search   :: String
  , hash     :: String
  }

derive newtype instance showLocation :: Show Location
derive instance genericLocation :: Generic Location _


-- TODO Add missing worker navigator specific fields
-- https://html.spec.whatwg.org/multipage/workers.html#workernavigator

newtype Navigator = Navigator
  { appCodeName :: String
  , appName     :: String
  , appVersion  :: String
  , platform    :: String
  , product     :: String
  , productSub  :: String
  , userAgent   :: String
  , vendor      :: String
  , vendorSub   :: String
  , language    :: String
  , languages   :: Array String
  , onLine      :: Boolean
  }

derive newtype instance showNavigator :: Show Navigator
derive instance genericNavigator :: Generic Navigator _


data WorkerType
  = Classic
  | Module

instance showWorkerType :: Show WorkerType where
  show workerType =
    case workerType of
      Classic -> "classic"
      Module  -> "module"

instance readWorkerType :: Read WorkerType where
  read s =
    case s of
      "classic" -> pure Classic
      "module"  -> pure Module
      _         -> Nothing


data Credentials
  = Omit
  | SameOrigin
  | Include

instance showCredentials :: Show Credentials where
  show cred =
    case cred of
      Omit       -> "omit"
      SameOrigin -> "same-origin"
      Include    -> "include"

instance readCredentials :: Read Credentials where
  read s =
    case s of
      "omit"        -> pure Omit
      "same-origin" -> pure SameOrigin
      "include"     -> pure Include
      _             -> Nothing


type Options =
  { name               :: String
  , requestCredentials :: Credentials
  , workerType         :: WorkerType
  }


--------------------
-- METHODS
--------------------


-- | Event handler for the `error` event.
onError
  :: forall worker. (AbstractWorker worker)
  => worker
  -> (Error -> Effect Unit)
  -> Effect Unit
onError = _onError


-- | Clones message and transmits it to the Worker object.
postMessage
  :: forall msg channel. (Channel channel)
  => channel
  -> msg
  -> Effect Unit
postMessage p msg = _postMessage p msg []


-- | Clones message and transmits it to the port object associated with
-- | dedicatedWorker-Global.transfer can be passed as a list of objects
-- | that are to be transferred rather than cloned.
postMessage'
  :: forall msg transfer channel. (Channel channel)
  => channel
  -> msg
  -> Array transfer
  -> Effect Unit
postMessage' = _postMessage


foreign import _onError
  :: forall worker
  .  worker
  -> (Error -> Effect Unit)
  -> Effect Unit


foreign import _postMessage
  :: forall msg transfer channel
  .  channel
  ->  msg
  -> Array transfer
  -> Effect Unit
