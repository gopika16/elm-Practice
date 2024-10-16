module Model exposing (..)


type alias Model =
    { startYear : Int
    , endYear : Int
    , leapYears : List Int
    }


initModel : Model
initModel =
    { startYear = 0
    , endYear = 0
    , leapYears = []
    }
