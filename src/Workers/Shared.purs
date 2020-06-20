module Workers.Shared
  -- * Types
  ( Shared
  , port

  -- * Constructors
  , new
  , new'

  -- * Re-Exports
  , module Workers
  , module MessagePort
  )
where

import Prelude

import Effect (Effect)

import MessagePort (MessagePort, close, start, onMessage, onMessageError)
import Workers (Credentials(..), Location, Navigator, Options, WorkerType(..),
    onError, postMessage, postMessage')
import Workers.Class (class AbstractWorker)


foreign import data Shared :: Type

instance abstractWorkerShared :: AbstractWorker Shared


-- | Returns a new Worker object. scriptURL will be fetched and executed in the
-- | background, creating a new global environment for which worker represents
-- | the communication channel.
new :: String -> Effect Shared
new url =
  _new url
    { name: ""
    , requestCredentials: (show Omit)
    , workerType: (show Classic)
    }


-- | Returns a new Worker object. scriptURL will be fetched and executed in the
-- | background, creating a new global environment for which worker represents
-- | the communication channel. options can be used to define the name of that
-- | global environment via the name option, primarily for debugging purposes.
-- | It can also ensure this new global environment supports JavaScript modules
-- | (specify type: "module"), and if that is specified, can also be used to
-- | specify how scriptURL is fetched through the credentials option
new' :: String -> Options -> Effect Shared
new' url opts =
  _new url
    { name: opts.name
    , requestCredentials: (show opts.requestCredentials)
    , workerType: (show opts.workerType)
    }


-- | Returns sharedWorker’s MessagePort object which can be used
-- | to communicate with the global environment.
port :: Shared -> MessagePort
port = _port


foreign import _new
  :: String
  -> { name :: String, requestCredentials :: String, workerType :: String }
  -> Effect Shared

foreign import _port :: Shared -> MessagePort
