module Model exposing (..)

import Entities exposing (UserData)
import Msg exposing (Msg)


type alias Model =
    { result : List UserData
    , error : String
    }


initalModel : () -> ( Model, Cmd Msg )
initalModel _ =
    ( { result = [], error = "" }, Cmd.none )
