module Main exposing (main)

import Color
import Html exposing (Html)
import Element exposing (..)
import Element.Attributes exposing (..)
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Transition as Transition
import Style.Shadow as Shadow


type alias Model =
    Maybe Int


type alias El =
    Element Style Variation Msg


type Msg
    = NoOp


type Variation
    = NoVary


type Style
    = None
    | App
    | Brand
    | Link
    | Button



-- Color Palette


coral : Color.Color
coral =
    Color.rgb 255 116 109


jet : Color.Color
jet =
    Color.rgb 70 70 70


linkStyles : List (Property class variation)
linkStyles =
    [ Color.text coral
    , Font.size 18
    , Font.underline
    , Font.weight 600
    , Transition.transitions
        [ Transition.Transition 0
            300
            "ease-out"
            [ "color"
            ]
        ]
    , hover
        [ Color.text jet
        ]
    ]


stylesheet : StyleSheet Style variation
stylesheet =
    Style.styleSheet
        [ style None []
        , style App
            [ Font.typeface
                [ Font.importUrl
                    { url = "https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600"
                    , name = "Source Sans Pro"
                    }
                , Font.font "Arial"
                ]
            ]
        , style Link linkStyles
        , style Brand
            (linkStyles
                ++ [ Font.size 28
                   ]
            )
        , style Button
            [ Color.text coral
            , Color.border coral
            , Border.rounded 4
            , Border.all 1
            , Font.lineHeight 1.2
            , Font.weight 600
            , Font.size 18
            , Transition.transitions
                [ Transition.Transition 0
                    300
                    "ease-out"
                    [ "box-shadow"
                    , "color"
                    , "border-color"
                    , "transform"
                    ]
                ]
            , hover
                [ Color.text jet
                , Color.border jet
                , translate 0 -1 0
                , Shadow.box
                    { offset = ( 0, 1 )
                    , size = 1
                    , blur = 2
                    , color = Color.rgba 30 30 30 0.05
                    }
                ]
            ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = Nothing
        , update = update
        , view = view
        }


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html Msg
view model =
    Element.viewport stylesheet <|
        row App
            [ width fill, height fill, center ]
            [ column None
                [ width fill, height fill, maxWidth (px 960) ]
                [ navbar
                ]
            ]


navbar : El
navbar =
    row None
        [ padding 16, width fill, verticalCenter ]
        [ link "/" <|
            el Brand [] (text "Jangle")
        , row None
            [ width fill, alignRight, verticalCenter, spacing 24 ]
            [ link "#guide" <|
                el Link [] (text "Guide")
            , link "#docs" <|
                el Link [] (text "Docs")
            , newTab "https://github.com/jangle-cms" <|
                el Button [ paddingXY 20 10 ] (text "View on Github")
            ]
        ]
