module Main exposing (..)

import Browser
import Model exposing (Model, initalModel)
import Msg exposing (Msg)
import Result exposing (Result(..))
import Update exposing (update)
import View exposing (view)


main : Program () Model Msg
main =
    Browser.element
        { init = initalModel
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub msg
subscriptions _ =
    Sub.none
