module Main exposing (main)

import Browser
import Init exposing (init)
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
        , subscriptions = \_ -> Sub.none
        , update = update
        , view = view
        }
