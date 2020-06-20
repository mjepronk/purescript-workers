module ApplicationCache
  ( ApplicationCache
  , Status(..)
  , abort
  , status
  , update
  , swapCache
  )
where

import Prelude
import Effect (Effect)


data Status
  = Uncached
  | Idle
  | Checking
  | Downloading
  | UpdateReady
  | Obsolete


type StatusRec =
  { uncached    :: Status
  , idle        :: Status
  , checking    :: Status
  , downloading :: Status
  , updateReady :: Status
  , obsolete    :: Status
  }


status :: ApplicationCache -> Status
status =
  _status { uncached: Uncached
          , idle: Idle
          , checking: Checking
          , downloading: Downloading
          , updateReady: UpdateReady
          , obsolete: Obsolete
          }

foreign import data ApplicationCache :: Type

foreign import abort :: ApplicationCache -> Effect Unit

foreign import _status :: StatusRec -> ApplicationCache -> Status

foreign import swapCache :: ApplicationCache -> Effect Unit

foreign import update :: ApplicationCache -> Effect Unit
