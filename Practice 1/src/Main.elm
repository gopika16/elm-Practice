module Main exposing (main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
    Browser.sandbox
        { init = "Welcome"
        , view = view
        , update = update
        }


type Msg
    = Wish
    | Reset

type alias Model =
    { message : String
    , name : String
    }

view data =
    div []
        [ 
         button [ onClick Wish ] [ text "Wish" ]
        , button [ onClick Reset ] [ text "reset" ]
        , Html.text data
        ]


update msg model =
    case msg of
        Wish ->
            "Welcome To My Elm App"

        Reset ->
            ""
