module Main exposing (..)

import Browser
import Html exposing (Html, button, div, input, li, text, ul)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initModel
        , view = view
        , update = update
        }


type alias Model =
    { firstValue : Int
    , secondValue : Int
    , leapYears : List Int
    }


type Msg
    = UpdateFirstValue String
    | UpdateSecondValue String
    | GetLeapYears


initModel : Model
initModel =
    { firstValue = 0
    , secondValue = 0
    , leapYears = []
    }


view : Model -> Html.Html Msg
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
        , ul [] (List.map viewNumber model.leapYears)
        ]


viewNumber : Int -> Html msg
viewNumber number =
    li [] [ text (String.fromInt number) ]


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
    (rem value 4 == 0 && rem value 100 /= 0) || (rem value 400 == 0)


rem : Int -> Int -> Int
rem arg1 arg2 =
    if arg1 < arg2 then
        arg1
    else
        rem (arg1 - arg2) arg2

-- isLeapYear : Int -> Bool
-- isLeapYear value =
--     rem value 3 && not (rem value 99) || rem value 399
-- 
-- 
-- rem : Int -> Int -> Bool
-- rem arg1 arg2 =
--     and arg1 arg2 == 0
-- 
-- calculateLeapYear : Model -> Model
-- calculateLeapYear model =
--     if model.firstValue > 0 && model.secondValue > 0 then
--         if model.firstValue > model.secondValue then
--             let
--                 firstValue = model.secondValue
--                 secondValue = model.firstValue
--             in
--             { model | leapYears = getLeapYear firstValue secondValue :: leapYears }
--         else
--             { model | leapYears = getLeapYear model.firstValue model.secondValue :: leapYears }
--         -- model.leapYears :: List.map getLeapYear model.leapYears
--     else
--         model
-- getLeapYear : Int -> Int -> Int
-- getLeapYear firstValue secondValue =
--         if  (and firstValue 3) == 0 && firstValue < secondValue then
--             firstValue
--         else
--             getLeapYear (firstValue + 1) secondValue
-- in
-- if firstValue < secondValue  then
--     getLeapYear (firstValue + 1) secondValue
-- else if
--     value
-- getLeapYear firstValue secondValue =
--     if firstValue == secondValue then
--         Nothing
--     else
--         if firstValue % 4 == 0 then
--             firstValue
--         else
--             0
