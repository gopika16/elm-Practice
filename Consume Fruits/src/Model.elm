module Model exposing (..)


type alias Model =
    { totalFruits : Int
    , days : List Int
    }


initialModel : Model
initialModel =
    { totalFruits = 0
    , days = []
    }
