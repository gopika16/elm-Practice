module View exposing (..)


import Model exposing (Model)
import Html exposing (..)
import Msg exposing (Msg(..))
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (value)

view : Model -> Html Msg
view model =
    div []
        [ input
            [ onInput UpdateFirstValue
            , value (String.fromInt model.firstValue)
            ]
            []
        , input
            [ onInput UpdateSecondValue
            , value (String.fromInt model.secondValue)
            ]
            []
        , button [ onClick GetLeapYears ] [ text "check" ]
        , ul [] (List.map showLeapYears model.leapYears)
        ]

showLeapYears : Int -> Html msg
showLeapYears number =
    li [] [ text (String.fromInt number) ]