module Update exposing (..)

import Model exposing (Model)
import Msg exposing (Msg(..))


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetValue value ->
            { model
                | value = Maybe.withDefault 0 (String.toInt value)
                , days = []
            }

        CalculateFruits ->
            calculateFruits model


calculateFruits : Model -> Model
calculateFruits model =
    let
        splitFruits =
            model.value // 7

        remainingFruits =
            modBy 7 model.value

        list =
            List.repeat 7 splitFruits

        newList =
            List.indexedMap (distribute remainingFruits) list
    in
    { model | days = newList }


distribute : comparable -> comparable -> number -> number
distribute remainingFruits index listElement =
    if remainingFruits > index then
        listElement + 1

    else
        listElement
