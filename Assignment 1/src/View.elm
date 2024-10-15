module View exposing (..)

import Html exposing (Html, button, div, h1, p, text)
import Html.Attributes exposing (hidden, style)
import Html.Events
import Model exposing (Model)
import Msg exposing (Msg(..))


view : Model -> Html Msg
view model =
    div
        [ style "text-align" "center"
        , style "font-size" "40px"
        , style "color" "green"
        ]
        [ div
            [ style "display" "flex"
            , style "justify-content" "center"
            , style "align-items" "center"
            ]
            [ button
                [ Html.Events.onClick FetchData
                , style "font-size" "20px"
                , style "background-color" "green"
                , style "border-radius" "20px"
                , style "padding" "10px"
                ]
                [ text "Request User Info" ]
            ]
        , p [ style "color" "red" ] [ text model.error ]
        , h1
            [ style "margin-top" "10%"
            , style "background-color" "cyan"
            ]
            [ text "User Info" ]
        , div [ hidden model.hideData ]
            [ p
                []
                [ text (String.fromInt model.result.id) ]
            , p
                []
                [ text (String.fromInt model.result.followers) ]
            , p
                []
                [ text model.result.name ]
            , p
                []
                [ text model.result.company ]
            ]
        ]
