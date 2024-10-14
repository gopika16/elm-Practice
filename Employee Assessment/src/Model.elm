module Model exposing (..)

import Entities exposing (Employee)


type alias Model =
    { employeeList : List Employee
    }


initialModel : Model
initialModel =
    { employeeList =
        [ { name = "Avi"
          , age = 28
          , role = "BA"
          , salary = 24000
          }
        , { name = "Viv"
          , age = 34
          , role = "Dev"
          , salary = 19000
          }
        , { name = "Diya"
          , age = 26
          , role = "QA"
          , salary = 26000
          }
        , { name = "Rey"
          , age = 30
          , role = "Dev"
          , salary = 25000
          }
        , { name = "Ana"
          , age = 29
          , role = "BA"
          , salary = 38000
          }
        , { name = "Arj"
          , age = 32
          , role = "QA"
          , salary = 22000
          }
        , { name = "Sia"
          , age = 27
          , role = "Dev"
          , salary = 30000
          }
        ]
    }
