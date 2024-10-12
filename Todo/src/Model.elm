module Model exposing (..)

type alias Task =
    { id : Int
    , isComplete : Bool
    , description : String
    , isEditing : Bool
    }

type alias Model =
    { allTasks : List Task
    , newTask : Maybe String
    , editTaskDescription : Maybe String
    }

initialModel : Model
initialModel =
    { allTasks =
        [ { id = 1, isComplete = True, description = "Task 1", isEditing = False }
        , { id = 2, isComplete = False, description = "Task 2", isEditing = False }
        , { id = 3, isComplete = True, description = "Task 3", isEditing = False }
        ]
    , newTask = Nothing
    , editTaskDescription = Nothing
    }
