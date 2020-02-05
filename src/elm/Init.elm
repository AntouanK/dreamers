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
      , text = "What do you dream to sell?"
      , withInput = True
      , label = "Steady your aim!"
      , answer = ""
      }
    , { id = 2
      , text = "What area do you dream to work in?"
      , withInput = True
      , label = "Position ready!"
      , answer = ""
      }
    , { id = 3
      , text = "How much revenue will you make?"
      , withInput = True
      , label = "Feelin' good!"
      , answer = ""
      }
    , { id = 4
      , text = "What's your email address?"
      , withInput = True
      , label = "Slam it!"
      , answer = ""
      }
    ]
