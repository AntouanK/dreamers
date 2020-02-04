module Init exposing (init)

import Browser.Navigation exposing (Key)
import Types.Flags exposing (Flags)
import Types.Model exposing (Model)
import Types.Msg exposing (Msg(..))
import Types.Question exposing (Question)
import Url exposing (Url)


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init _ _ _ =
    let
        model =
            { questions = initialQuestions
            , maybeQuestionIdToShow = Nothing
            }
    in
    ( model, Cmd.none )


initialQuestions : List Question
initialQuestions =
    [ { id = 1
      , text = "What do you want to do?"
      }
    , { id = 2
      , text = "Where do you want to work?"
      }
    , { id = 3
      , text = "How much revenue are you looking to make?"
      }
    ]
