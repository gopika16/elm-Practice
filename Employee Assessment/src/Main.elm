module Main exposing (..)

import Browser
import Model exposing (..)
import Msg exposing (Msg)
import Update exposing (update)
import View exposing (view)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
