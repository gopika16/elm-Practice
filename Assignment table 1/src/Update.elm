module Update exposing (..)

import Decoder exposing (userDetailsDecoder)
import Http
import Json.Decode as Decode exposing (Error(..))
import Model exposing (Model)
import Msg exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchData ->
            ( model
            , Http.get
                { url = "https://api.github.com/users"
                , expect = Http.expectJson LoadData (Decode.list userDetailsDecoder)
                }
            )

        LoadData result ->
            case result of
                Ok userInfo ->
                    ( { model | result = userInfo, error = "" }, Cmd.none )

                Err _ ->
                    ( { model | result = [], error = "An Error Occured" }, Cmd.none )
