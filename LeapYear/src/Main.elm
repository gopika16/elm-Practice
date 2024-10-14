module Main exposing (..)

import Browser
import Msg exposing (Msg)
import Model exposing (initModel, Model)
import View exposing (view)
import Update exposing (update)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initModel
        , view = view
        , update = update
        }
