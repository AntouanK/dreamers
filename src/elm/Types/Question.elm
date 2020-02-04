module Types.Question exposing (Question, QuestionId)


type alias Question =
    { id : QuestionId
    , text : String
    , withInput : Bool
    , label : String
    , answer : String
    }


type alias QuestionId =
    Int
