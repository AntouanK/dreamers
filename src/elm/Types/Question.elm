module Types.Question exposing (Question, QuestionId)


type alias Question =
    { id : QuestionId
    , text : String
    }


type alias QuestionId =
    Int
