module Types.Model exposing (Model)

import Types.Question exposing (Question)
import Types.Route exposing (Route)


type alias Model =
    { questions : List Question
    , route : Route
    }
