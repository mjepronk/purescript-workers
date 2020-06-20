module GlobalScope.Shared
  ( name
  , applicationCache
  , onConnect
  , module GlobalScope
  , module ApplicationCache
  )
where

import Prelude
import Effect (Effect)
import Data.NonEmpty (NonEmpty(..))

import ApplicationCache  (ApplicationCache, Status(..), abort, status,
    swapCache, update)
import GlobalScope (close, location, navigator, onError, onLanguageChange,
    onOffline, onOnline, onRejectionHandled, onUnhandledRejection)
import MessagePort (MessagePort)


-- | Returns sharedWorkerGlobal’s name, i.e. the value given to the SharedWorker
-- | constructor. Multiple SharedWorker objects can correspond to the same
-- | shared worker (and SharedWorkerGlobalScope), by reusing the same name.
foreign import name :: Effect String


-- | The applicationCache attribute returns the ApplicationCache object for the worker.
foreign import applicationCache :: Effect ApplicationCache


-- | Event handler for the `connect` event
onConnect :: (NonEmpty Array MessagePort -> Effect Unit) -> Effect Unit
onConnect = _onConnect NonEmpty


foreign import _onConnect
  :: (MessagePort -> Array MessagePort -> NonEmpty Array MessagePort)
  -> (NonEmpty Array MessagePort -> Effect Unit)
  -> Effect Unit
