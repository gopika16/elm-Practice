module Decoder exposing (..)

import Entities exposing (UserData)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)


userDetailsDecoder : Decoder UserData
userDetailsDecoder =
    Decode.succeed UserData
        |> required "id" Decode.int
        |> required "login" Decode.string
        |> required "avatar_url" Decode.string
