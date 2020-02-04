module Types.Model exposing (Model)

import Types.Question exposing (Question, QuestionId)


type alias Model =
    { questions : List Question
    , maybeQuestionIdToShow : Maybe QuestionId
    }
