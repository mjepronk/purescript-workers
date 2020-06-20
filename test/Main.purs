module Test.Main where

import Prelude
import Effect.Aff (launchAff_)
import Effect.Aff.AVar as A
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Exception (Error, name)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Mocha (runMocha)

import Aff.Workers (Location(..), Navigator(..))
import Aff.Workers.Dedicated (Dedicated)
import Aff.Workers.Shared (Shared)
import Aff.MessagePort as MessagePort
import Aff.Workers.Dedicated as DedicatedWorker
import Aff.Workers.Shared as SharedWorker
import Aff.Workers.Service as ServiceWorker


main :: Effect Unit
main = runMocha do
  describe "[Dedicated Worker]" do
    it "Hello World" do
      var <- A.empty
      (worker :: Dedicated) <- DedicatedWorker.new "base/worker01.js"
      DedicatedWorker.onMessage worker (\msg -> launchAff_ do
        A.put msg var
      )
      DedicatedWorker.postMessage worker "hello"
      msg <- A.take var
      msg `shouldEqual` "world"

    it "WorkerLocation object" do
      var <- A.empty
      (worker :: Dedicated) <- DedicatedWorker.new "base/worker02.js"
      DedicatedWorker.onMessage worker (\msg -> launchAff_ do
        A.put msg var
      )
      DedicatedWorker.postMessage worker unit
      Location loc <- A.take var
      loc.pathname `shouldEqual` "/base/worker02.js"

    it "WorkerNavigator object" do
      var <- A.empty
      (worker :: Dedicated) <- DedicatedWorker.new "base/worker03.js"
      DedicatedWorker.onMessage worker (\msg -> launchAff_ do
        A.put msg var
      )
      DedicatedWorker.postMessage worker unit
      Navigator nav <- A.take var
      nav.onLine `shouldEqual` true

    it "Error Event - Handled by Worker" do
      var <- A.empty
      (worker :: Dedicated) <- DedicatedWorker.new "base/worker05.js"
      DedicatedWorker.onMessage worker (\msg -> launchAff_ do
        A.put msg var
      )
      msg <- A.take var
      msg `shouldEqual` "Error"

    it "Error Event - Bubble to Parent" do
      (var :: A.AVar Error) <- A.empty
      (worker :: Dedicated) <- DedicatedWorker.new "base/worker06.js"
      DedicatedWorker.onError worker (\err -> launchAff_ $ A.put err var)
      err <- A.take var
      name err `shouldEqual` "Error"

    it "Data Clone Error" do
      var <- A.empty
      (worker :: Dedicated) <- DedicatedWorker.new "base/worker07.js"
      DedicatedWorker.onMessage worker (\msg -> launchAff_ do
        A.put msg var
      )
      msg <- A.take var
      msg `shouldEqual` "DataCloneError"

    it "Worker terminate" do
      var <- A.empty
      (worker :: Dedicated) <- DedicatedWorker.new "base/worker01.js"
      DedicatedWorker.onMessage worker (\msg -> launchAff_ do
        DedicatedWorker.terminate worker
        A.put unit var
      )
      DedicatedWorker.postMessage worker "patate"
      msg <- A.take var
      msg `shouldEqual` unit


  describe "[Shared Worker]" do
    it "Shared Worker Connect" do
      var <- A.empty
      (worker :: Shared) <- SharedWorker.new "base/worker04.js"
      MessagePort.onMessage (SharedWorker.port worker) (\msg -> launchAff_ do
        A.put msg var
      )
      (msg :: Boolean) <- A.take var
      msg `shouldEqual` true


  describe "[Service Worker]" do
    it "Service Worker - using get with source id" do
      var <- A.empty
      registration <- ServiceWorker.register "base/worker08.js"
      liftEffect $ ServiceWorker.onMessage (\msg ->
        launchAff_ $ A.put msg var
      )
      worker <- ServiceWorker.wait
      ServiceWorker.postMessage worker "patate"
      msg <- A.take var
      msg `shouldEqual` "PATATE"


    it "Service Worker - matching all clients" do
      var <- A.empty
      registration <- ServiceWorker.register "base/worker09.js"
      liftEffect $ ServiceWorker.onMessage (\msg ->
        launchAff_ $ A.put msg var
      )
      worker <- ServiceWorker.wait
      ServiceWorker.postMessage worker "patate"
      msg <- A.take var
      msg `shouldEqual` "PATATE"


it' :: String -> Effect Unit -> Spec Unit
it' str body = it str (liftEffect body)
