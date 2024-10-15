module View exposing (..)

import Entities exposing (UserData)
import Html exposing (Html, button, div, img, p, table, td, text, th, thead, tr)
import Html.Attributes exposing (alt, src, style)
import Html.Events
import Model exposing (Model)
import Msg exposing (Msg(..))


view : Model -> Html Msg
view model =
    div
        []
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
                , style "padding" "20px"
                ]
                [ text "Request User Info" ]
            ]
        , p [] [ text model.error ]
        , table
            [ style "letter-spacing" "1px"
            , style "border" "2px solid black"
            ]
            (getTableHeader :: List.map getTableRow model.result)
        ]


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
