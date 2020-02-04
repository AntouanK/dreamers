module Types.Msg exposing (Msg(..))

import Browser exposing (UrlRequest)
import Types.Question exposing (Question)
import Url exposing (Url)


type Msg
    = NoOp
    | UrlRequested UrlRequest
    | ChangedUrl Url
    | GoToQuestion Question
