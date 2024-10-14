module View exposing (..)

import Entities exposing (Employee)
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Msg exposing (Msg(..))


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ button [ onClick Promote ] [ text "Promote Employees" ]
            , button [ onClick SortList ] [ text "Sort" ]
            , button [ onClick Reset ] [ text "Reset" ]
            ]
        , table
            [ style "letter-spacing" "1px"
            ]
            [ thead []
                [ tr []
                    [ th [] [ text "Name" ]
                    , th [] [ text "Age" ]
                    , th [] [ text "Role" ]
                    , th [] [ text "Salary" ]
                    ]
                ]
            , tbody []
                (List.map getEmployeeList model.employeeList)
            ]
        ]


getEmployeeList : Employee -> Html msg
getEmployeeList employee =
    tr
        []
        [ td
            [ style "padding" "5px" ]
            [ text employee.name ]
        , td [ style "padding" "5px" ]
            [ text (String.fromInt employee.age)
            ]
        , td
            [ style "padding" "5px"
            ]
            [ text employee.role
            ]
        , td [ style "padding" "5px" ]
            [ text (String.fromInt employee.salary)
            ]
        ]
