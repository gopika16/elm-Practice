module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model)
import Msg exposing (Msg(..))


view : Model -> Html Msg
view model =
    div []
        [ input
            [ onInput UpdateStartYear
            , value (String.fromInt model.startYear)
            ]
            []
        , input
            [ onInput UpdateEndYear
            , value (String.fromInt model.endYear)
            ]
            []
        , button [ onClick GetLeapYears ] [ text "check" ]
        , ul [] (List.map showLeapYears model.leapYears)
        ]


showLeapYears : Int -> Html msg
showLeapYears number =
    li [] [ text (String.fromInt number) ]
