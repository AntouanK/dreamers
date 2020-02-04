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
        , displayFlex
        , flex
        , flexDirection
        , fontFamilies
        , fontSize
        , hex
        , int
        , justifyContent
        , margin2
        , minHeight
        , minWidth
        , none
        , outline
        , pct
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
import Types.Model exposing (Model)
import Types.Msg exposing (Msg(..))
import Types.Question exposing (Question, QuestionId)
import Types.Route exposing (Route(..))


render : Model -> Html.Html Msg
render model =
    let
        { route, questions } =
            model

        bgId =
            case route of
                QuestionSection id ->
                    id

                _ ->
                    0

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
                    [ text "chat" ]
    in
    toUnstyled <|
        node "root"
            [ css <| cssRoot bgId ]
            [ node "center-content"
                [ css cssCenterContent ]
                mainContent
            ]


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
    , property "animation" "fadein 1s"
    ]


cssInputEle : List Style
cssInputEle =
    [ backgroundColor transparent
    , borderStyle none
    , fontSize (px 50)
    , textAlign center
    , outline none
    , borderBottom3 (px 2) solid (hex "FEFEFE")
    , width (pct 100)
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


cssCenterContent : List Style
cssCenterContent =
    [ flex (int 1)
    , flexDirection column
    , alignItems center
    , property "animation" "fadein 1s"
    , displayFlex
    , color <| hex "d36044"

    --  , padding2 (px 240) (px 30)
    , justifyContent center
    , property "background" "linear-gradient(0deg, rgba(0,212,255,0) 0%, rgba(214, 214, 220, 0.88) 35%, rgba(214, 214, 220, 0.88) 65%, rgba(0,212,255,0) 100%)"
    ]
