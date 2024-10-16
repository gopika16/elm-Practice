module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style, value)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model)
import Msg exposing (Msg(..))


view : Model -> Html Msg
view model =
    div
        [ style "margin" "20%"
        ]
        [ text "Add number : "
        , input [ onInput SetTotalFruits, value (String.fromInt model.totalFruits) ] []
        , button [ onClick DistributeFruits ] [ text "Calculate" ]
        , div []
            [ if model.totalFruits > 0 then
                ul []
                    (List.map showFruitDays model.days)

              else
                text "-----------------Add fruits----------------"
            ]
        ]


showFruitDays : Int -> Html msg
showFruitDays number =
    li [] [ text (String.fromInt number) ]
