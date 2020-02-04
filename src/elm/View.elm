module View exposing (view)

import Browser exposing (Document)
import Components.Root as C_Root
import Types.Model exposing (Model)
import Types.Msg exposing (Msg)


view : Model -> Document Msg
view model =
    { title = "your page title here"
    , body = [ C_Root.render model ]
    }
