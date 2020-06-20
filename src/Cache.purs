module Cache
  -- * Types
  ( Cache
  , CacheStorage
  , CacheQueryOptions
  , defaultCacheQueryOptions

  -- * Cache Storage Manipulations
  , deleteCache
  , hasCache
  , keysCache
  , openCache

  -- * Cache Manipulations
  , add
  , addAll
  , delete
  , delete'
  , keys
  , keys'
  , match
  , match'
  , matchAll
  , matchAll'
  , put
  )
where

import Prelude
import Effect.Aff (Aff)
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toNullable, toMaybe)

import Fetch (Response, RequestInfo)


foreign import data Cache :: Type

foreign import data CacheStorage :: Type


type CacheQueryOptions =
  { ignoreSearch :: Boolean
  , ignoreMethod :: Boolean
  , ignoreVary   :: Boolean
  }


defaultCacheQueryOptions :: CacheQueryOptions
defaultCacheQueryOptions =
  { ignoreSearch : false
  , ignoreMethod : false
  , ignoreVary   : false
  }


-- Cache Storage

deleteCache :: CacheStorage -> String -> Aff Boolean
deleteCache = _deleteCache

hasCache :: CacheStorage -> String -> Aff Boolean
hasCache = _hasCache

keysCache :: CacheStorage -> Aff (Array String)
keysCache = _keysCache

openCache :: CacheStorage -> String -> Aff Cache
openCache = _openCache


-- Cache

add :: Cache -> RequestInfo -> Aff Unit
add = _add

addAll :: Cache -> Array RequestInfo -> Aff Unit
addAll = _addAll

delete :: Cache -> RequestInfo -> Aff Boolean
delete cache req = _delete cache req defaultCacheQueryOptions

delete' :: Cache -> RequestInfo -> CacheQueryOptions -> Aff Boolean
delete' = _delete

keys :: Cache -> Aff (Array RequestInfo)
keys cache = _keys cache (toNullable Nothing) defaultCacheQueryOptions

keys'
  :: Cache
  -> Maybe RequestInfo
  -> CacheQueryOptions
  -> Aff (Array RequestInfo)
keys' cache req opts = _keys cache (toNullable req) opts

match :: Cache -> RequestInfo -> Aff (Maybe Response)
match cache req = toMaybe <$> _match cache req defaultCacheQueryOptions

match'
  :: Cache
  -> RequestInfo
  -> CacheQueryOptions
  -> Aff (Maybe Response)
match' cache req opts = toMaybe <$>_match cache req opts


matchAll :: Cache -> Aff (Array Response)
matchAll cache = _matchAll cache (toNullable Nothing) defaultCacheQueryOptions

matchAll'
  :: Cache
  -> Maybe RequestInfo
  -> CacheQueryOptions
  -> Aff (Array Response)
matchAll' cache req opts = _matchAll cache (toNullable req) opts


put :: Cache -> RequestInfo -> Response -> Aff Unit
put = _put


-- Cache Storage

foreign import _deleteCache :: CacheStorage -> String -> Aff Boolean

foreign import _hasCache :: CacheStorage -> String -> Aff Boolean

foreign import _keysCache :: CacheStorage -> Aff (Array String)

foreign import _openCache :: CacheStorage -> String -> Aff Cache


-- Cache

foreign import _add :: Cache -> String -> Aff Unit

foreign import _addAll :: Cache -> Array String -> Aff Unit

foreign import _delete
  :: Cache
  -> String
  -> CacheQueryOptions
  -> Aff Boolean

foreign import _keys
  :: Cache
  -> Nullable String
  -> CacheQueryOptions
  -> Aff (Array String)

foreign import _match
  :: Cache
  -> String
  -> CacheQueryOptions
  -> Aff (Nullable Response)

foreign import _matchAll
  :: Cache
  -> Nullable String
  -> CacheQueryOptions
  -> Aff (Array Response)

foreign import _put :: Cache -> String -> Response -> Aff Unit
