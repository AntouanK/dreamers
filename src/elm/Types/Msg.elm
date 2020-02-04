module Types.Msg exposing (Msg(..))

import Browser exposing (UrlRequest)
import Types.Route exposing (Route)
import Url exposing (Url)


type Msg
    = NoOp
    | UrlRequested UrlRequest
    | ChangedUrl Url
    | GoToRoute Route
