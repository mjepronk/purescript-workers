module Main where

import Prelude

import Effect.Aff (Aff)
import Effect.Aff.Console (log)
import Effect (Effect)
import Effect.Class (liftEffect)
import Data.Maybe (Maybe)

import Cache as Cache
import Fetch (Request, Response, fetch, requestURL)
import GlobalScope.Service (onInstall, onFetch, caches)


main :: Effect Unit
main = preCache *> fromCache


-- Our cache name in the cache storage
cacheName :: String
cacheName = "cache-and-update"


-- Register an event listener for the `install` event
--
-- This is called once at the beginning when the cache first get initialized
preCache :: Effect Unit
preCache = onInstall $ do
  log "The service worker is being installed"
  storage <- liftEffect caches
  cache   <- Cache.openCache storage cacheName
  Cache.addAll cache
    [ "./controlled.html"
    , "./asset"
    ]


-- Register an event listener for the `fetch` event
--
-- There are 2 phases here:
--
-- - first, we immediately handle the response to the request
-- - secondly, we update the cache in background with the actual response
fromCache :: Effect Unit
fromCache = onFetch respondWith waitUntil
  where
    respondWith :: Request -> Aff (Maybe Response)
    respondWith req = do
      log "The service worker is serving the asset."
      storage <- liftEffect caches
      cache   <- Cache.openCache storage cacheName
      Cache.match cache (requestURL req)

    waitUntil :: Request -> Aff Unit
    waitUntil req = do
      storage <- liftEffect caches
      cache   <- Cache.openCache storage cacheName
      res     <- fetch req
      Cache.put cache (requestURL req) res
