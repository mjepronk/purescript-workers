module GlobalScope
  ( location
  , navigator
  , close
  , onError
  , onLanguageChange
  , onOffline
  , onOnline
  , onRejectionHandled
  , onUnhandledRejection
  ) where

import Prelude

import Effect (Effect)
import Effect.Exception (Error)

import Workers (Location(..), Navigator(..))


location :: Effect Location
location = _location Location

navigator :: Effect Navigator
navigator = _navigator Navigator


foreign import _location :: forall a. (a -> Location) -> Effect Location

foreign import _navigator :: forall a. (a -> Navigator) -> Effect Navigator

foreign import close :: Effect Unit

foreign import onError :: (Error -> Effect Unit) -> Effect Unit

foreign import onLanguageChange :: Effect Unit -> Effect Unit

foreign import onOffline :: Effect Unit -> Effect Unit

foreign import onOnline :: Effect Unit -> Effect Unit

foreign import onRejectionHandled :: Effect Unit -> Effect Unit

foreign import onUnhandledRejection :: Effect Unit -> Effect Unit
