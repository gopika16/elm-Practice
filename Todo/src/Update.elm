module Update exposing (update)

import Model exposing (..)
import Msg exposing (..)


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTask ->
            case model.newTask of
                Just newTaskDescription ->
                    let
                        newTask =
                            { id = List.length model.allTasks + 1
                            , isComplete = False
                            , description = newTaskDescription
                            , isEditing = False
                            }
                    in
                    { model
                        | allTasks = newTask :: model.allTasks
                        , newTask = Nothing
                    }

                Nothing ->
                    model

        NewTask newTaskDescription ->
            { model | newTask = Just newTaskDescription }

        ToggleTask id ->
            let
                updatedTasks =
                    List.map (toggleComplete id) model.allTasks
            in
            { model | allTasks = updatedTasks }

        DeleteTask id ->
            { model | allTasks = List.filter (\task -> task.id /= id) model.allTasks }

        EditTask id ->
            let
                updatedTasks =
                    List.map (startEdit id) model.allTasks
            in
            { model | allTasks = updatedTasks }

        UpdateTaskDescription id newDescription ->
            { model
                | editTaskDescription = Just newDescription
            }

        SaveTaskEdit id ->
            let
                updatedTasks =
                    List.map (saveEdit id model.editTaskDescription) model.allTasks
            in
            { model | allTasks = updatedTasks, editTaskDescription = Nothing }

toggleComplete : Int -> Task -> Task
toggleComplete id task =
    if task.id == id then
        { task | isComplete = not task.isComplete }
    else
        task

startEdit : Int -> Task -> Task
startEdit id task =
    if task.id == id then
        { task | isEditing = True }
    else
        task

saveEdit : Int -> Maybe String -> Task -> Task
saveEdit id maybeNewDescription task =
    case maybeNewDescription of
        Just newDescription ->
            if task.id == id then
                { task | description = newDescription, isEditing = False }
            else
                task

        Nothing ->
            task
