module Types.Msg exposing (Msg(..))

import Browser exposing (UrlRequest)
import Time exposing (Posix)
import Types.Question exposing (QuestionId)
import Types.Route exposing (Route)
import Url exposing (Url)


type Msg
    = NoOp
    | UrlRequested UrlRequest
    | ChangedUrl Url
    | GoToRoute Route
    | UpdateTime Posix
    | SetAnswer QuestionId String
