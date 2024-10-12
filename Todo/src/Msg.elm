module Msg exposing (..)

type Msg
    = AddTask
    | NewTask String
    | ToggleTask Int
    | DeleteTask Int
    | EditTask Int
    | UpdateTaskDescription Int String
    | SaveTaskEdit Int
