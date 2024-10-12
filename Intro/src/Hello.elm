module Hello exposing (..)

import Browser
import Debug exposing (toString)
import Html exposing (button, div, input, p, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)


type alias Model =
    { welcome : String, name : String, visit : Int }


type Msg
    = Clicked
    | Add
    | NameChanged String


initialModel : Model
initialModel =
    { welcome = "Welcome to Elm world ", name = "Gopika", visit = 1 }


main =
    Browser.sandbox { init = initialModel, view = view, update = update }


view model =
    div []
        [ text model.welcome
        , p [] [ text model.name ]
        , p [] [ text (" Visit count " ++ toString model.visit) ]
        , input [ onInput NameChanged, value model.name ] []
        , button [ onClick Clicked ] [ text "Visit Again !" ]
        , button [ onClick Add ] [ text "Add !" ]
        ]


update msg model =
    case msg of
        Clicked ->
            { model | visit = model.visit + 1 }

        Add ->
            { model | name = model.name ++ "!" }

        NameChanged newName ->
            { model | name = newName }
