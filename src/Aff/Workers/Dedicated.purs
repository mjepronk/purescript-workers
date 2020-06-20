module Aff.Workers.Dedicated
  ( new
  , new'
  , terminate
  , onMessage
  , onMessageError
  , module Workers.Dedicated
  , module Aff.Workers
  )
where


import Prelude

import Effect.Aff (Aff)
import Effect (Effect)
import Effect.Exception (Error)
import Effect.Class (liftEffect)

import Aff.Workers (Credentials(..), Location, Navigator, Options,
    WorkerType(..), onError, postMessage, postMessage')
import Workers.Dedicated (Dedicated)
import Workers.Dedicated as W


-- | Returns a new Worker object. scriptURL will be fetched and executed in the
-- | background, creating a new global environment for which worker represents
-- | the communication channel.
new :: String -> Aff Dedicated
new = liftEffect <<< W.new

-- | Returns a new Worker object. scriptURL will be fetched and executed in the
-- | background, creating a new global environment for which worker represents
-- | the communication channel. options can be used to define the name of that
-- | global environment via the name option, primarily for debugging purposes.
-- | It can also ensure this new global environment supports JavaScript modules
-- | (specify type: "module"), and if that is specified, can also be used to
-- | specify how scriptURL is fetched through the credentials option
new' :: String -> Options -> Aff Dedicated
new' url = liftEffect <<< W.new' url

-- | Aborts worker’s associated global environment.
terminate :: Dedicated -> Aff Unit
terminate = liftEffect <<< W.terminate

-- | Event handler for the `message` event
onMessage :: forall msg .  Dedicated -> (msg -> Effect Unit) -> Aff Unit
onMessage p = liftEffect <<< W.onMessage p

-- | Event handler for the `messageError` event
onMessageError :: Dedicated -> (Error -> Effect Unit) -> Aff Unit
onMessageError p = liftEffect <<< W.onMessageError p
