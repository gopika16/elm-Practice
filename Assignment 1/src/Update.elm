module Update exposing (..)

import Decoder exposing (userDetailsDecoder)
import Http
import Json.Decode exposing (Error(..))
import Model exposing (Model)
import Msg exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchData ->
            ( model
            , Http.get
                { url = "https://api.github.com/users/1"
                , expect = Http.expectJson LoadData userDetailsDecoder
                }
            )

        LoadData result ->
            case result of
                Ok userInfo ->
                    let
                        newResult =
                            userInfo
                    in
                    ( { model | result = newResult, hideData = False }, Cmd.none )

                Err _ ->
                    ( { model | error = "Error occured", hideData = True }, Cmd.none )
