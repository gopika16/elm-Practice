module Update exposing (..)

import Model exposing (Model)
import Msg exposing (Msg(..))


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateFirstValue value ->
            { model
                | firstValue = Maybe.withDefault 0 (String.toInt value)
                , leapYears = []
            }

        UpdateSecondValue value ->
            { model
                | secondValue = Maybe.withDefault 0 (String.toInt value)
                , leapYears = []
            }

        GetLeapYears ->
            calculateLeapYear model


calculateLeapYear : Model -> Model
calculateLeapYear model =
    if model.firstValue > 0 && model.secondValue > 0 then
        if model.firstValue > model.secondValue then
            let
                firstValue =
                    model.secondValue + 1

                secondValue =
                    model.firstValue
            in
            { model | leapYears = getLeapYear firstValue secondValue model.leapYears }

        else
            { model | leapYears = getLeapYear (model.firstValue + 1) model.secondValue model.leapYears }

    else
        model


getLeapYear : Int -> Int -> List Int -> List Int
getLeapYear firstValue secondValue list =
    if firstValue >= secondValue then
        list

    else if isLeapYear firstValue then
        getLeapYear (firstValue + 1) secondValue (firstValue :: list)

    else
        getLeapYear (firstValue + 1) secondValue list


isLeapYear : Int -> Bool
isLeapYear value =
    (modBy 4 value == 0 && modBy 100 value /= 0) || (modBy 400 value == 0)
