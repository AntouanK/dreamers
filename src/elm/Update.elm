module Update exposing (update)

import Types.Model exposing (Model)
import Types.Msg exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ChangedUrl _ ->
            ( model, Cmd.none )

        UrlRequested _ ->
            ( model, Cmd.none )

        GoToQuestion question ->
            let
                newModel =
                    { model | maybeQuestionIdToShow = Just question.id }
            in
            ( newModel, Cmd.none )
