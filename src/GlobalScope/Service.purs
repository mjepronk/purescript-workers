module GlobalScope.Service
  -- * Global Scope
  ( caches
  , clients
  , registration
  , skipWaiting
  , onInstall
  , onActivate
  -- , onFetch
  , onMessage

  -- * Clients Interface
  , Clients
  , ClientQueryOptions
  , get
  , matchAll
  , matchAll'
  , openWindow
  , claim

  -- * Client Interface
  , Client
  , ClientId
  , ClientType(..)
  , url
  , frameType
  , clientId

  -- * Window Client Interface
  , WindowClient
  , FrameType(..)
  , VisibilityState(..)
  , visibilityState
  , focused
  , focus
  , navigate
  )
where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toMaybe, toNullable)
import Data.String.Read (class Read, read)

import Workers.Service (Registration)
import Workers.Class (class Channel)
import Cache (CacheStorage)
import Fetch (Request, Response)


foreign import data Clients :: Type

foreign import data Client :: Type

instance channelClient :: Channel Client


foreign import data WindowClient :: Type

type ClientId = String

type ClientQueryOptions =
  { includeUncontrolled :: Boolean
  , clientType :: ClientType
  }


data ClientType
  = Window
  | Worker
  | SharedWorker
  | All

instance showClientType :: Show ClientType where
  show =
    case _ of
      Window       -> "window"
      Worker       -> "worker"
      SharedWorker -> "sharedworker"
      All          -> "all"

instance readClientType :: Read ClientType where
  read s =
    case s of
      "window"       -> pure Window
      "worker"       -> pure Worker
      "sharedworker" -> pure SharedWorker
      "all"          -> pure All
      _              -> Nothing


data FrameType
  = Auxiliary
  | TopLevel
  | Nested
  | None

instance showFrameType :: Show FrameType where
  show x =
    case x of
      Auxiliary -> "auxiliary"
      TopLevel  -> "top-level"
      Nested    -> "nested"
      None      -> "none"

instance readFrameType :: Read FrameType where
  read s =
    case s of
      "auxiliary" -> pure Auxiliary
      "top-level" -> pure TopLevel
      "nested"    -> pure Nested
      "none"      -> pure None
      _           -> Nothing


data VisibilityState
  = Hidden
  | Visible
  | PreRender
  | Unloaded

instance showVisibilityState :: Show VisibilityState where
  show x =
    case x of
      Hidden    -> "hidden"
      Visible   -> "visible"
      PreRender -> "prerender"
      Unloaded  -> "unloaded"

instance readVisibilityState :: Read VisibilityState where
  read s =
    case s of
      "hidden"    -> pure Hidden
      "visible"   -> pure Visible
      "prerender" -> pure PreRender
      "unloaded"  -> pure Unloaded
      _           -> Nothing



-- Global Scope

caches :: Effect CacheStorage
caches = _caches

clients :: Effect Clients
clients = _clients

registration :: Effect Registration
registration = _registration

skipWaiting :: Effect Unit
skipWaiting = _skipWaiting

onInstall :: Aff Unit -> Effect Unit
onInstall = _onInstall

onActivate :: Effect Unit -> Effect Unit
onActivate = _onActivate

onFetch :: (Request -> Aff (Maybe Response)) -> (Request -> Aff Unit) -> Effect Unit
onFetch f = _onFetch toNullable f

onMessage :: forall msg. (ClientId -> msg -> Effect Unit) -> Effect Unit
onMessage = _onMessage


-- Clients Interface

get :: Clients -> ClientId -> Aff (Maybe Client)
get cls cid = toMaybe <$> fromEffectFnAff (_get cls cid)

matchAll :: Clients -> Aff (Array Client)
matchAll cls = fromEffectFnAff $ _matchAll cls
    { includeUncontrolled: false, clientType: Window }

matchAll' :: Clients -> ClientQueryOptions -> Aff (Array Client)
matchAll' cls cqo = fromEffectFnAff $ _matchAll cls cqo

openWindow :: Clients -> String -> Aff WindowClient
openWindow cls s = fromEffectFnAff $ _openWindow cls s

claim :: Clients -> Aff Unit
claim cls = fromEffectFnAff $ _claim cls


-- Client Interface

url :: Client -> String
url = _url

frameType :: Client -> FrameType
frameType = _frameType (read >>> toNullable)

clientId :: Client -> ClientId
clientId =  _clientId


-- Window Client Interface

visibilityState :: WindowClient -> VisibilityState
visibilityState = _visibilityState (read >>> toNullable)

focused :: WindowClient -> Boolean
focused = _focused

focus :: WindowClient -> Aff WindowClient
focus wc = fromEffectFnAff $ _focus wc

navigate :: WindowClient -> String -> Aff WindowClient
navigate wc s = fromEffectFnAff $ _navigate wc s


-- Global Scope

foreign import _caches :: Effect CacheStorage

foreign import _clients :: Effect Clients

foreign import _registration :: Effect Registration

foreign import _skipWaiting :: Effect Unit

-- TODO
foreign import _onInstall :: Aff Unit -> Effect Unit

foreign import _onActivate :: Effect Unit -> Effect Unit

-- TODO
foreign import _onFetch
  :: forall a
  .  (Maybe a -> Nullable a)
  -> (Request -> Aff (Maybe Response))
  -> (Request -> Aff Unit)
  -> Effect Unit

foreign import _onMessage
  :: forall msg. (ClientId -> msg -> Effect Unit) -> Effect Unit


-- Clients Interface

foreign import _get :: Clients -> ClientId -> EffectFnAff (Nullable Client)

foreign import _matchAll :: Clients -> ClientQueryOptions -> EffectFnAff (Array Client)

foreign import _openWindow :: Clients -> String -> EffectFnAff WindowClient

foreign import _claim :: Clients -> EffectFnAff Unit


-- Client Interface

foreign import _url :: Client -> String

-- NOTE The null case is "unsafely" ignored
foreign import _frameType
  :: (String -> Nullable FrameType)
  -> Client
  -> FrameType

foreign import _clientId
  :: Client
  -> ClientId

-- Window Client Interface

-- NOTE The null case is "unsafely" ignored
foreign import _visibilityState
  :: (String -> Nullable VisibilityState)
  -> WindowClient
  -> VisibilityState

foreign import _focused :: WindowClient -> Boolean

foreign import _focus :: WindowClient -> EffectFnAff WindowClient

foreign import _navigate :: WindowClient -> String -> EffectFnAff WindowClient
