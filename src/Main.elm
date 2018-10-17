module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, button, div, h1, h2, h3, input, p, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onMouseOver)

main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { current : Int
    , selected : Int
    , userInput : Int
    }


init : () -> (Model, Cmd Msg)
init _ =
    ({ current = 0
    , selected = 0
    , userInput = 0
    }
    , Cmd.none)



-- UPDATE


type Msg
    = Increment
    | Decrement
    | Reset
    | Input String
    | Select


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Increment ->
            ({ model
                | current = model.current + model.selected
            }, Cmd.none)

        Decrement ->
            ({ model
                | current = model.current - model.selected
            }, Cmd.none)

        Reset ->
            ({ model
                | current = 0
            }, Cmd.none)

        Input val ->
            ({ model
                | userInput = Maybe.withDefault 0 (String.toInt val)
            }, Cmd.none)

        Select ->
            ({ model
                | selected = model.userInput
                , userInput = 0
                , current = 0
            }, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW


type alias Document msg =
  { title : String
  , body : List (Html msg)
  }

view : Model -> Document Msg
view model =
    { title = "CountByApp"
    , body = [ div []
        [ h1 []
            [ text "The \"Count By\" App" ]
        , div []
            [ input
                [ value
                    (if model.userInput == 0 then
                        ""

                     else
                        String.fromInt model.userInput
                    )
                , onInput Input
                , autofocus True
                ]
                []
            ]
        , button
            [ type_ "button", onClick Select ]
            [ text "Select" ]
        , div []
            [ h2 []
                [ text
                    (if model.selected == 0 then
                        "Select a number to get started!"

                     else
                        "You've chosen to count by " ++ String.fromInt model.selected ++ "s"
                    )
                ]
            ]
        , div []
            [ h3 []
                [ text (String.fromInt model.current)
                ]
            ]
        , button
            [ onClick Increment ]
            [ text "+" ]
        , button
            [ onClick Decrement ]
            [ text "-" ]
        , div []
            [ button [ onClick Reset ] [ text "Reset" ]
            ]
        ]
    ]
    }
