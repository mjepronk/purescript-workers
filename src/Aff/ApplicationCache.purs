module Aff.ApplicationCache
  ( abort
  , swapCache
  , update
  , module ApplicationCache
  )
where

import Prelude

import Effect.Aff (Aff)
import Effect.Class (liftEffect)

import ApplicationCache as A
import ApplicationCache (ApplicationCache, Status(..), status)


abort :: ApplicationCache -> Aff Unit
abort = liftEffect <<< A.abort

swapCache :: ApplicationCache -> Aff Unit
swapCache = liftEffect <<< A.swapCache

update :: ApplicationCache -> Aff Unit
update = liftEffect <<< A.update
