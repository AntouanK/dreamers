module Init exposing (init)

import Browser.Navigation exposing (Key)
import Types.Flags exposing (Flags)
import Types.Model exposing (Model)
import Types.Msg exposing (Msg(..))
import Types.Question exposing (Question)
import Types.Route exposing (Route(..))
import Url exposing (Url)


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init _ _ _ =
    let
        model =
            { questions = initialQuestions
            , route = Start
            }
    in
    ( model, Cmd.none )


initialQuestions : List Question
initialQuestions =
    [ { id = 1
      , text = "What do you want to do?"
      , withInput = True
      , label = "next"
      }
    , { id = 2
      , text = "Where do you want to work?"
      , withInput = True
      , label = "next"
      }
    , { id = 3
      , text = "How much revenue are you looking to make?"
      , withInput = True
      , label = "next"
      }
    , { id = 4
      , text = "complete the aptitude test"
      , withInput = False
      , label = "go"
      }
    ]
