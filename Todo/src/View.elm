module View exposing (view)

import Entities exposing (Task)
import Html exposing (Html, button, div, h1, input, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (checked, style, type_, value)
import Html.Events exposing (onClick, onInput, onMouseLeave)
import Model exposing (Model)
import Msg exposing (Msg(..))


view : Model -> Html Msg
view model =
    div
        [ style "margin" "50%"
        , style "margin-top" "10%"
        , onMouseLeave ResetId
        ]
        [ h1 [] [ text "Todo Tasks" ]
        , input
            [ onInput NewTask
            , style "width" "150px"
            , value (Maybe.withDefault "" model.newTask)
            ]
            []
        , button
            [ onClick AddTask
            , style "font-size" "20px"
            , style "padding" "10px"
            , style "width" "150px"
            ]
            [ text "Add Task" ]
        , table
            [ style "letter-spacing" "1px"
            , style "border" "2px solid black"
            , style "width" "19%"
            , style "margin-top" "15%"
            ]
            [ thead []
                [ tr []
                    [ th [] [ text "Status" ]
                    , th [] [ text "Description" ]
                    , th [] [ text "Delete" ]
                    ]
                ]
            , tbody []
                (List.map (getTableRow model.editingTaskId) model.allTasks)
            ]
        ]


getTableRow : Maybe Int -> Task -> Html Msg
getTableRow editingTaskId data =
    tr
        []
        [ td [ style "padding" "5px" ]
            [ input
                [ type_ "checkbox"
                , checked data.isComplete
                , onClick (ToggleTask data.id)
                ]
                []
            ]
        , td
            [ style "padding" "5px"
            , style "text-decoration"
                (if data.isComplete then
                    "line-through"

                 else
                    "none"
                )
            , onClick (EditTask data.id)
            ]
            [ if Just data.id == editingTaskId then
                input
                    [ type_ "text"
                    , value data.description
                    , onInput SaveEditedTask
                    ]
                    []

              else
                text data.description
            ]
        , td [ style "padding" "5px" ]
            [ button
                [ onClick (DeleteTask data.id)
                , style "background-color" "red"
                ]
                [ text "Delete" ]
            ]
        ]
