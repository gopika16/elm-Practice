module Update exposing (..)

import Model exposing (Model)
import Msg exposing (Msg(..))


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateStartYear value ->
            { model
                | startYear = Maybe.withDefault 0 (String.toInt value)
                , leapYears = []
            }

        UpdateEndYear value ->
            { model
                | endYear = Maybe.withDefault 0 (String.toInt value)
                , leapYears = []
            }

        GetLeapYears ->
            calculateLeapYear model


calculateLeapYear : Model -> Model
calculateLeapYear model =
    if model.startYear > 0 && model.endYear > 0 then
        if model.startYear > model.endYear then
            let
                firstValue =
                    model.endYear + 1

                secondValue =
                    model.startYear
            in
            { model | leapYears = getLeapYear firstValue secondValue model.leapYears }

        else
            { model | leapYears = getLeapYear (model.startYear + 1) model.endYear model.leapYears }

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
