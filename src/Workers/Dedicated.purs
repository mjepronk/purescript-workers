module Workers.Dedicated
  -- * Types
  ( Dedicated
  , terminate
  , onMessage
  , onMessageError

  -- * Constructors
  , new
  , new'

  -- * Re-exports
  , module Workers
  )
where

import Prelude

import Effect (Effect)
import Effect.Exception (Error)

import Workers (Credentials(..), Location, Navigator, Options, WorkerType(..),
    onError, postMessage, postMessage')
import Workers.Class (class AbstractWorker, class Channel)


foreign import data Dedicated :: Type

instance abstractWorkerDedicated :: AbstractWorker Dedicated

instance channelDedicated :: Channel Dedicated


-- | Returns a new Worker object. scriptURL will be fetched and executed in the background,
-- | creating a new global environment for which worker represents the communication channel.
new :: String -> Effect Dedicated
new url =
  _new url
    { name: ""
    , requestCredentials: (show Omit)
    , workerType: (show Classic)
    }


-- | Returns a new Worker object. scriptURL will be fetched and executed in the background,
-- | creating a new global environment for which worker represents the communication channel.
-- | options can be used to define the name of that global environment via the name option,
-- | primarily for debugging purposes. It can also ensure this new global environment supports
-- | JavaScript modules (specify type: "module"), and if that is specified, can also be used
-- | to specify how scriptURL is fetched through the credentials option
new' :: String -> Options -> Effect Dedicated
new' url opts =
  _new url
    { name: opts.name
    , requestCredentials: (show opts.requestCredentials)
    , workerType: (show opts.workerType)
    }


-- | Aborts worker’s associated global environment.
terminate :: Dedicated -> Effect Unit
terminate = _terminate


-- | Event handler for the `message` event
onMessage :: forall msg. Dedicated -> (msg -> Effect Unit) -> Effect Unit
onMessage port = _onMessage port


-- | Event handler for the `messageError` event
onMessageError :: Dedicated -> (Error -> Effect Unit) -> Effect Unit
onMessageError port = _onMessageError port


foreign import _onMessage :: forall msg. Dedicated -> (msg -> Effect Unit) -> Effect Unit

foreign import _onMessageError :: Dedicated -> (Error -> Effect Unit) -> Effect Unit

foreign import _new
  :: String
  -> { name :: String, requestCredentials :: String, workerType :: String }
  -> Effect Dedicated

foreign import _terminate :: Dedicated -> Effect Unit
