module Init exposing (init)

import Browser.Navigation exposing (Key)
import Time exposing (millisToPosix)
import Types.Flags exposing (Flags)
import Types.Model exposing (Model)
import Types.Msg exposing (Msg(..))
import Types.Question exposing (Question)
import Types.Route exposing (Route(..))
import Url exposing (Url)


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags _ _ =
    let
        model =
            { questions = initialQuestions
            , route = Start
            , now = flags.now |> millisToPosix
            , maybeTimeSubmitted = Nothing
            }
    in
    ( model, Cmd.none )


initialQuestions : List Question
initialQuestions =
    [ { id = 1
      , text = "What do you want to do?"
      , withInput = True
      , label = "next"
      , answer = ""
      }
    , { id = 2
      , text = "Where do you want to work?"
      , withInput = True
      , label = "sounds good"
      , answer = ""
      }
    , { id = 3
      , text = "How much revenue are you looking for?"
      , withInput = True
      , label = "that will do"
      , answer = ""
      }
    , { id = 4
      , text = "do you have an email address?"
      , withInput = True
      , label = "let's go"
      , answer = ""
      }
    ]
