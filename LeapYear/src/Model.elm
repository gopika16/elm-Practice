module Model exposing (..)


type alias Model =
    { firstValue : Int
    , secondValue : Int
    , leapYears : List Int
    }


initModel : Model
initModel =
    { firstValue = 0
    , secondValue = 0
    , leapYears = []
    }
