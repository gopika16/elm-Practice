module Main exposing (..)

import Browser
import Html exposing (text)
import Json.Decode exposing (Decoder)
import Http


main : Program () Model Msg
main =
    Browser.element
        { init = initModel
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


initModel : () -> ( Model, Cmd Msg )
initModel _ =
    ( { title = "Testing" }, getTitle )



view : Model -> Html.Html msg
view model =
    text model.title

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TaskTitle result ->
            case result of
                Ok data ->
                    ( { model | title = data }, Cmd.none )

                Err _ ->
                    ( { model | title = "error" }, Cmd.none )


subscriptions : Model -> Sub msg
subscriptions _ =
    Sub.none


type alias Model =
    { title : String
    }


type Msg
    = TaskTitle (Result Http.Error String)


getTitle : Cmd Msg
getTitle =
    Http.get
        { url = "https://jsonplaceholder.typicode.com/todos/3 "
        , expect = Http.expectJson TaskTitle titleDecoder
        }


titleDecoder : Decoder String
titleDecoder =
    Json.Decode.field "title" Json.Decode.string
