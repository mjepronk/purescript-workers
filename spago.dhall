{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "workers"
, license =
    "MIT"
, repository =
    "https://github.com/mjepronk/purescript-workers.git"
, dependencies =
    [ "console"
    , "aff"
    , "argonaut"
    , "avar"
    , "effect"
    , "generics-rep"
    , "http"
    , "nullable"
    , "psci-support"
    , "read"
    , "spec"
    , "spec-mocha"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
