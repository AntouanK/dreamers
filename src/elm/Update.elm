module Update exposing (update)

import Time exposing (millisToPosix, posixToMillis)
import Types.Model exposing (Model)
import Types.Msg exposing (Msg(..))
import Types.Route exposing (Route(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ChangedUrl _ ->
            ( model, Cmd.none )

        UrlRequested _ ->
            ( model, Cmd.none )

        GoToRoute route ->
            let
                newModel =
                    case route of
                        ChatSoon ->
                            { model
                                | route = route
                                , maybeTimeSubmitted =
                                    ((model.now |> posixToMillis) - 100)
                                        |> millisToPosix
                                        |> Just
                            }

                        _ ->
                            { model | route = route }
            in
            ( newModel, Cmd.none )

        UpdateTime posix ->
            let
                newModel =
                    { model | now = posix }
            in
            ( newModel, Cmd.none )

        SetAnswer questionId answer ->
            let
                newQuestions =
                    model.questions
                        |> List.map
                            (\question ->
                                if question.id == questionId then
                                    { question | answer = answer }

                                else
                                    question
                            )

                newModel =
                    { model | questions = newQuestions }
            in
            ( newModel, Cmd.none )
