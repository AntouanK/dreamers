module Types.Route exposing (Route(..))

import Types.Question exposing (QuestionId)


type Route
    = Start
    | ChatSoon
    | QuestionSection QuestionId
