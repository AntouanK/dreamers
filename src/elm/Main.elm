module Main exposing (main)

import Browser
import Init exposing (init)
import Time exposing (every)
import Types.Flags exposing (Flags)
import Types.Model exposing (Model)
import Types.Msg exposing (Msg(..))
import Update exposing (update)
import View exposing (view)



-- MAIN


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , onUrlChange = ChangedUrl
        , onUrlRequest = UrlRequested
        , subscriptions = \_ -> every 1000 UpdateTime
        , update = update
        , view = view
        }
