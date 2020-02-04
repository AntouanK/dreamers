module Components.Root exposing (render)

import Css
    exposing
        ( Style
        , alignItems
        , backgroundColor
        , backgroundImage
        , backgroundPosition
        , backgroundSize
        , borderBottom3
        , borderStyle
        , center
        , color
        , column
        , cover
        , cursor
        , display
        , displayFlex
        , flex
        , flexDirection
        , fontFamilies
        , fontSize
        , hex
        , inlineBlock
        , int
        , justifyContent
        , margin2
        , minHeight
        , minWidth
        , none
        , outline
        , padding
        , pointer
        , property
        , px
        , solid
        , textAlign
        , textDecoration
        , transparent
        , underline
        , url
        , vh
        , vw
        , width
        , zero
        )
import Html
import Html.Styled exposing (Html, input, node, text, toUnstyled)
import Html.Styled.Attributes exposing (css, disabled, id, placeholder, type_, value)
import Html.Styled.Events exposing (onClick)
import Time exposing (posixToMillis)
import Types.Model exposing (Model)
import Types.Msg exposing (Msg(..))
import Types.Question exposing (Question, QuestionId)
import Types.Route exposing (Route(..))


render : Model -> Html.Html Msg
render model =
    let
        { route, questions, now, maybeTimeSubmitted } =
            model

        bgId =
            case route of
                Start ->
                    0

                QuestionSection id ->
                    id

                ChatSoon ->
                    8

        mainContent =
            case route of
                Start ->
                    case List.filter (.id >> (==) 1) questions of
                        [ firstQuestion ] ->
                            [ node "start-link"
                                [ css cssStartLink
                                , onClick <|
                                    GoToRoute <|
                                        QuestionSection firstQuestion.id
                                ]
                                [ text "Build your dream" ]
                            ]

                        _ ->
                            []

                QuestionSection questionId ->
                    renderQuestion questions questionId

                ChatSoon ->
                    case maybeTimeSubmitted of
                        Just timeSubmitted ->
                            let
                                diff =
                                    secondsForDays 3
                                        - ((posixToMillis now
                                                - posixToMillis timeSubmitted
                                           )
                                            // 1000
                                          )

                                seconds =
                                    diff |> modBy 60

                                minutes =
                                    diff // 60 |> modBy 60

                                hours =
                                    diff // 60 // 60
                            in
                            [ node "timer-text"
                                [ css [ fontSize (px 60) ] ]
                                [ text <|
                                    "Hang in there. We'll contact you before "
                                        ++ "this timer runs out"
                                ]
                            , node "time-section"
                                []
                                [ node "time-unit"
                                    [ css cssTimeUnit ]
                                    [ text <| String.fromInt hours ]
                                , text "hours"
                                , node "time-unit"
                                    [ css cssTimeUnit ]
                                    [ text <| String.fromInt minutes ]
                                , text "minutes"
                                , node "time-unit"
                                    [ css cssTimeUnit ]
                                    [ text <| String.fromInt seconds ]
                                , text "seconds"
                                ]
                            ]

                        Nothing ->
                            [ text "whooops. no submission time found" ]
    in
    toUnstyled <|
        node "root"
            [ css <| cssRoot bgId ]
            [ node "center-content"
                [ css cssCenterContent ]
                mainContent
            ]


secondsForDays : Int -> Int
secondsForDays days =
    days * 24 * 60 * 60


renderQuestion : List Question -> QuestionId -> List (Html Msg)
renderQuestion questions questionId =
    let
        maybeThisQuestion =
            questions
                |> List.filter (.id >> (==) questionId)
                |> List.head

        maybeNextQuestion =
            questions
                |> List.filter (.id >> (==) (questionId + 1))
                |> List.head
    in
    case maybeThisQuestion of
        Just question ->
            let
                extraAttributes =
                    case maybeNextQuestion of
                        Just nextQuestion ->
                            [ onClick <| GoToRoute <| QuestionSection nextQuestion.id ]

                        Nothing ->
                            [ onClick <| GoToRoute ChatSoon ]

                attributes =
                    [ css cssNext
                    , disabled <| not <| .withInput <| question
                    ]
                        ++ extraAttributes
            in
            [ inputEle question
            , node "next"
                attributes
                [ text question.label ]
            ]

        _ ->
            [ text "nothing" ]


inputEle : Question -> Html Msg
inputEle question =
    input
        [ css cssInputEle
        , type_ "text"
        , id <| String.fromInt question.id
        , value ""
        , placeholder question.text
        ]
        []



-- ------------------------------------


cssRoot : Int -> List Style
cssRoot bgId =
    [ minHeight (vh 100)
    , minWidth (vw 100)
    , fontFamilies [ "Cambay", "sans-serif" ]
    , backgroundImage <| url <| "/images/" ++ String.fromInt bgId ++ ".jpg"
    , backgroundPosition center
    , backgroundSize cover
    , displayFlex
    , flexDirection column
    , justifyContent center
    , alignItems center
    , property "animation" "fadein 1s"
    ]


cssInputEle : List Style
cssInputEle =
    [ backgroundColor transparent
    , borderStyle none
    , fontSize (px 50)
    , textAlign center
    , outline none
    , borderBottom3 (px 2) solid (hex "343434")
    , width (px 770)
    ]


cssStartLink : List Style
cssStartLink =
    [ fontSize (px 70)
    , textDecoration underline
    , cursor pointer
    ]


cssNext : List Style
cssNext =
    [ fontSize (px 40)
    , margin2 (px 20) zero
    , cursor pointer
    ]


cssTimeUnit : List Style
cssTimeUnit =
    [ fontSize (px 40)
    , textAlign center
    , display inlineBlock
    , width (px 65)
    ]


cssCenterContent : List Style
cssCenterContent =
    [ flex (int 0)
    , flexDirection column
    , alignItems center
    , property "animation" "fadein 1s"
    , displayFlex
    , color <| hex "d36044"
    , padding (px 40)
    , justifyContent center
    , backgroundColor <| hex "FDFDFD"
    , property "box-shadow" "5px 5px 1px #d36044"

    --, property "background" "linear-gradient(0deg, rgba(0,212,255,0) 0%, rgba(214, 214, 220, 0.88) 35%, rgba(214, 214, 220, 0.88) 65%, rgba(0,212,255,0) 100%)"
    ]
