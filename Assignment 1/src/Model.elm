module Model exposing (..)

import Entities exposing (UserInfo)
import Msg exposing (Msg)


type alias Model =
    { result : UserInfo, error : String, hideData : Bool }


initalModel : () -> ( Model, Cmd Msg )
initalModel _ =
    ( { result =
            { id = 0
            , name = ""
            , company = ""
            , followers = 0
            }
      , error = ""
      , hideData = True
      }
    , Cmd.none
    )
