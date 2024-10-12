module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (checked, style, type_, value)
import Html.Events exposing (onClick, onInput)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }


initialModel : Model
initialModel =
    { allTasks =
        [ { id = 1
          , isComplete = True
          , description = "Task 1"
          }
        , { id = 2
          , isComplete = False
          , description = "Task 2"
          }
        , { id = 3
          , isComplete = True
          , description = "Task 3"
          }
        ]
    , newTask = Nothing
    , editingTaskId = Nothing
    }


type alias Model =
    { allTasks : List Task
    , newTask : Maybe String
    , editingTaskId : Maybe Int
    }


type alias Task =
    { id : Int
    , isComplete : Bool
    , description : String
    }


type Msg
    = AddTask
    | NewTask String
    | ToggleTask Int
    | DeleteTask Int
    | EditTask Int
    | SaveEditedTask String


view : Model -> Html Msg
view model =
    div
        [ style "margin" "50%"
        , style "margin-top" "10%"
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
                    , th [] [ text "Edit" ]
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
            ]
            [  text data.description
            ]
        , td [ style "padding" "5px" ]
            [ input
                [ type_ "button"
                , onClick (EditTask data.id)
                , style "background-color" "yellow"
                ]
                []
            ]
        , td [ style "padding" "5px" ]
            [ input
                [ type_ "button"
                , onClick (DeleteTask data.id)
                , style "background-color" "red"
                ]
                []
            ]
        , td [ style "padding" "5px" ]
            [ if Just data.id == editingTaskId then
                input 
                    [ type_ "text"
                    , value data.description
                    , onInput SaveEditedTask -- Handle input changes to save edited task
                    ]
                    []
              else
                text data.description
            ] 
        ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTask ->
            case model.newTask of
                Just aTask ->
                    let
                        newTask =
                            { id = List.length model.allTasks + 1
                            , isComplete = False
                            , description = aTask
                            }
                    in
                    { model
                        | allTasks = newTask :: model.allTasks
                        , newTask = Nothing
                    }

                Nothing ->
                    model

        NewTask newTask ->
            if String.trim newTask == "" then
                { model
                    | newTask = Nothing
                }

            else
                { model
                    | newTask = Just newTask
                }

        ToggleTask id ->
            let
                updatedTasks =
                    List.map (updateTaskStatus id) model.allTasks
            in
            { model | allTasks = updatedTasks }

        DeleteTask id ->
            { model | allTasks = List.filter (\task -> task.id /= id) model.allTasks }

        
        EditTask id ->
            { model | editingTaskId = Just id } -- Set the ID of the task being edited

        SaveEditedTask newDescription ->
            case model.editingTaskId of 
                Just id ->
                    let updatedTasks =
                            List.map (updateEditedDescription id newDescription) model.allTasks 
                    in 
                    { model | allTasks = updatedTasks, editingTaskId = Nothing } -- Reset editing state
                
                Nothing ->
                    model


updateEditedDescription : Int -> String -> Task -> Task
updateEditedDescription id newDescription task =
    if task.id == id then
        { task | description = newDescription } -- Update description
        
    else 
        task
        -- EditTask id ->
        --     let
        --         updatedTasks =
        --             List.map (editTask id model) model.allTasks
        --     in
        --     { model | allTasks = updatedTasks }


editTask : Int -> Model -> Task -> Task
editTask id model task =
    if task.id == id then
        task

    else
        task


updateTaskStatus : Int -> Task -> Task
updateTaskStatus id task =
    if task.id == id then
        let
            updatedTask =
                { task | isComplete = not task.isComplete }
        in
        updatedTask

    else
        task



--          RemoveStudent studentId ->
-- { model | students = List.filter (\student -> student.id /= studentId) model.students }
