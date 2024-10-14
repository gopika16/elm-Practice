module Update exposing (..)

import Entities exposing (Employee)
import List exposing (map)
import Model exposing (Model, initialModel)
import Msg exposing (Msg(..))


update : Msg -> Model -> Model
update msg model =
    case msg of
        Promote ->
            let
                newList =
                    map promoteEmployees model.employeeList
            in
            { model
                | employeeList = newList
            }

        SortList ->
            { model
                | employeeList = List.sortBy .name model.employeeList
            }

        Reset ->
            initialModel


promoteEmployees : Employee -> Employee
promoteEmployees employee =
    if employee.salary > 25000 then
        { employee | role = "Sr. " ++ employee.role }

    else
        employee
