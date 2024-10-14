module Model exposing (..)


type alias Model =
    { value : Int
    , days : List Int
    }


initialModel : Model
initialModel =
    { value = 0
    , days = []
    }
