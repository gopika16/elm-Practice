module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h1, p, text)
import Html.Attributes exposing (style)
import Html.Events
import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)
import RemoteData exposing (RemoteData(..))
import Result exposing (Result(..))


main : Program () Model Msg
main =
    Browser.element
        { init = initalModel
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { result : RemoteData Http.Error UserInfo }


type alias UserInfo =
    { id : Int
    , name : String
    , company : String
    , followers : Int
    }


type Msg
    = FetchData
    | LoadData (Result Http.Error UserInfo)


initalModel : () -> ( Model, Cmd Msg )
initalModel _ =
    ( { result = RemoteData.NotAsked }, Cmd.none )



-- View --


view : Model -> Html Msg
view model =
    case model.result of
        RemoteData.NotAsked ->
            div
                [ style "display" "flex"
                , style "justify-content" "center"
                , style "align-items" "center"
                , style "height" "100vh"
                ]
                [ button
                    [ Html.Events.onClick FetchData
                    , style "font-size" "40px"
                    , style "background-color" "green"
                    , style "border-radius" "20px"
                    , style "padding" "40px"
                    ]
                    [ text "Request User Info" ]
                ]

        RemoteData.Success data ->
            div
                [ style "text-align" "center"
                , style "font-size" "40px"
                , style "color" "green"
                ]
                [ h1
                    [ style "margin-top" "10%"
                    , style "background-color" "cyan"
                    ]
                    [ text "User Info" ]
                , p
                    []
                    [ text (String.fromInt data.id) ]
                , p
                    []
                    [ text (String.fromInt data.followers) ]
                , p
                    []
                    [ text data.name ]
                , p
                    []
                    [ text data.company ]
                ]

        _ ->
            text "There is some error" -- FallBack scenerio if there is some error, also can show particular error.
-- update --


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
                            Success userInfo
                    in
                    ( { model | result = newResult }, Cmd.none )

                Err error ->
                    ( { model | result = Failure error }, Cmd.none )


userDetailsDecoder : Decoder UserInfo
userDetailsDecoder =
    Decode.succeed UserInfo
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "company" Decode.string
        |> required "followers" Decode.int


subscriptions : Model -> Sub msg
subscriptions _ =
    Sub.none
