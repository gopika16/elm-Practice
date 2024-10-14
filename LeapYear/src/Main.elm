module Main exposing (..)

import Browser
import Model exposing (Model, initModel)
import Msg exposing (Msg)
import Update exposing (update)
import View exposing (view)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initModel
        , view = view
        , update = update
        }
