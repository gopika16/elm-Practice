module Update exposing (..)

import Model exposing (Model)
import Msg exposing (Msg(..))


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetTotalFruits value ->
            { model
                | totalFruits = Maybe.withDefault 0 (String.toInt value)
                , days = []
            }

        DistributeFruits ->
            calculateFruits model


calculateFruits : Model -> Model
calculateFruits model =
    let
        splitFruits =
            model.totalFruits // 7
        
        distributedFruits =
            List.repeat 7 splitFruits

        remainingFruits =
            modBy 7 model.totalFruits

    in
    { model | days = List.indexedMap (distribute remainingFruits) distributedFruits }


distribute : comparable -> comparable -> number -> number
distribute remainingFruits index listElement =
    if remainingFruits > index then
        listElement + 1

    else
        listElement
