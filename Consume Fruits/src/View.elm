module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Html.Attributes exposing (value)


view : Model -> Html Msg
view model =
    div
        [ style "margin" "20%"
        ]
        [ text "Add number : "
        , input [ onInput SetValue , value (String.fromInt model.value)] []
        , button [ onClick CalculateFruits ] [ text "Calculate" ]
        , div []
            [ if model.value > 0 then
                ul []
                    (List.map showFruitDays model.days)

              else
                text "-----------------Add fruits----------------"
            ]
        ]


showFruitDays : Int -> Html msg
showFruitDays number =
    li [] [ text (String.fromInt number) ]
