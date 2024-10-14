module Main exposing (..)

import Browser
import Model exposing (..)
import Msg exposing (Msg)
import Update exposing (update)
import View exposing (view)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }



-- We have a bucket and there are a random number of fruits in the bucket
-- ranging between 1 to 100. We have to consume all the fruits in 7 days
-- in such a way that we consume an equal number of fruits everyday.
-- For example if we got 14 fruits we can consume 2 everyday.
-- But if we got 10, then 2 fruits for 3 days and 1 on the fourth day.
-- similarly for any other random number.
-- But the condition is we have to finish all the fruits in 7 days.
