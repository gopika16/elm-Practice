module Msg exposing (..)

import Entities exposing (UserInfo)
import Http


type Msg
    = FetchData
    | LoadData (Result Http.Error UserInfo)
