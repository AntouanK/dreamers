module API exposing (submitAnswers)

import Http exposing (Error(..), expectWhatever, post, stringBody)
import Json.Encode as Encode
import Types.Msg exposing (Msg(..))


submitAnswers : List String -> Cmd Msg
submitAnswers answers =
    let
        body =
            stringBody
                "application/json"
                (Encode.encode 0 <| Encode.list Encode.string answers)
    in
    post
        { url = "http://78.46.198.28:3000/submit-answers"
        , body = body
        , expect = expectWhatever SubmittedAnswers
        }
