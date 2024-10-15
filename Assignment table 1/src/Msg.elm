module Msg exposing (..)

import Entities exposing (UserData)
import Http


type Msg
    = FetchData
    | LoadData (Result Http.Error (List UserData))
