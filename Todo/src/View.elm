module View exposing (view)

import Html exposing (Html, div, h1, input, button, table, thead, tr, th, tbody, td, text)
import Html.Attributes exposing (style, type_, value, checked)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Task)
import Msg exposing (Msg(..))



view : Model -> Html Msg
view model =
    div
        []
        [ h1 [] [ text "Todo Tasks" ]
        , input
            [ onInput NewTask
            , value (Maybe.withDefault "" model.newTask)
            ]
            []
        , button
            [ onClick AddTask ]
            [ text "Add Task" ]
        , taskTable model
        ]

taskTable : Model -> Html Msg
taskTable model =
    table []
        [ thead []
            [ tr []
                [ th [] [ text "Status" ]
                , th [] [ text "Description" ]
                , th [] [ text "Edit" ]
                , th [] [ text "Delete" ]
                ]
            ]
        , tbody [] (List.map (taskRow model) model.allTasks)
        ]

taskRow : Model -> Task -> Html Msg
taskRow model task =
    tr []
        [ td []
            [ input
                [ type_ "checkbox"
                , checked task.isComplete
                , onClick (ToggleTask task.id)
                ]
                []
            ]
        , td []
            [ if task.isEditing then
                input
                    [ value task.description
                    , onInput (UpdateTaskDescription task.id)
                    ]
                    []
              else
                text task.description
            ]
        , td []
            [ if task.isEditing then
                button [ onClick (SaveTaskEdit task.id) ] [ text "Save" ]
              else
                button [ onClick (EditTask task.id) ] [ text "Edit" ]
            ]
        , td []
            [ button [ onClick (DeleteTask task.id) ] [ text "Delete" ]
            ]
        ]
