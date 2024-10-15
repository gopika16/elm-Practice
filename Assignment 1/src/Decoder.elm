module Decoder exposing (..)

import Entities exposing (UserInfo)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)


userDetailsDecoder : Decoder UserInfo
userDetailsDecoder =
    Decode.succeed UserInfo
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "company" Decode.string
        |> required "followers" Decode.int
