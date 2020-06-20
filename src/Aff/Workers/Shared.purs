module Aff.Workers.Shared
  ( port
  , new
  , new'
  , module Workers.Shared
  , module Aff.MessagePort
  , module Aff.Workers
  )
where

import Prelude

import Effect.Aff (Aff)
import Effect.Class (liftEffect)

import Aff.MessagePort (MessagePort, close, start, onMessage, onMessageError)
import Aff.Workers (Credentials(..), Location, Navigator, Options,
    WorkerType(..), onError, postMessage, postMessage')
import Workers.Shared as W
import Workers.Shared (Shared)


-- | Returns a new Worker object. scriptURL will be fetched and executed in the
-- | background, creating a new global environment for which worker represents
-- | the communication channel.
new :: String -> Aff Shared
new = liftEffect <<< W.new


-- | Returns a new Worker object. scriptURL will be fetched and executed in the
-- | background, creating a new global environment for which worker represents
-- | the communication channel. options can be used to define the name of that
-- | global environment via the name option, primarily for debugging purposes.
-- | It can also ensure this new global environment supports JavaScript modules
-- | (specify type: "module"), and if that is specified, can also be used to
-- | specify how scriptURL is fetched through the credentials option
new' :: String -> Options -> Aff Shared
new' url = liftEffect <<< W.new' url


-- | Aborts worker’s associated global environment.
port :: Shared -> MessagePort
port = W.port
