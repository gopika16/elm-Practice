module Main exposing (..)

import Browser
import Html exposing (Html, button, div, img, table, td, text, th, thead, tr)
import Html.Attributes exposing (alt, src, style)
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
    { result : RemoteData Http.Error (List UserData)
    }


type alias UserData =
    { id : Int
    , login : String
    , avatar_url : String
    }


initalModel : () -> ( Model, Cmd Msg )
initalModel _ =
    ( { result = RemoteData.NotAsked }, Cmd.none )


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
                []
                [ table
                    [ style "letter-spacing" "1px"
                    , style "border" "2px solid black"
                    ]
                    (getTableHeader :: List.map getTableRow data)
                ]

        _ ->
            text "There is some error"


getTableHeader : Html msg
getTableHeader =
    thead
        [ style "font-size" "20px"
        , style "color" "green"
        ]
        [ tr []
            [ th [ style "padding" "5px" ] [ text "Image" ]
            , th [ style "padding" "5px" ] [ text "Id" ]
            , th [ style "padding" "5px" ] [ text "Name" ]
            ]
        ]


getTableRow : UserData -> Html msg
getTableRow data =
    tr
        []
        [ td [ style "padding" "5px" ]
            [ img
                [ src data.avatar_url
                , alt "User Avatar"
                , style "width" "50px"
                , style "height" "50px"
                , style "border-radius" "50%"
                ]
                []
            ]
        , td [ style "padding" "5px" ] [ text (String.fromInt data.id) ]
        , td [ style "padding" "5px" ] [ text data.login ]
        ]


type Msg
    = FetchData
    | LoadData (Result Http.Error (List UserData))


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
                    ( { model | result = Success userInfo }, Cmd.none )

                Err error ->
                    ( { model | result = Failure error }, Cmd.none )


userDetailsDecoder : Decoder UserData
userDetailsDecoder =
    Decode.succeed UserData
        |> required "id" Decode.int
        |> required "login" Decode.string
        |> required "avatar_url" Decode.string


subscriptions : Model -> Sub msg
subscriptions _ =
    Sub.none
