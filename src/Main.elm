module Main exposing (..)

import Array exposing (Array)
import Browser
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type Fill
    = White
    | Black


type alias Index =
    Int


type alias Cell =
    { fill : Fill
    , value : Maybe Char
    }


type alias Model =
    Array Cell


init : Model
init =
    Array.repeat (13 ^ 2) (Cell Black Maybe.Nothing)



-- UPDATE


type Msg
    = SwitchFill Index Fill



-- updateElement list


update : Msg -> Model -> Model
update msg model =
    case msg of
        SwitchFill index White ->
            Array.set index (Cell Black Maybe.Nothing) model

        SwitchFill index Black ->
            Array.set index (Cell White Maybe.Nothing) model



-- VIEW


renderCell : Index -> Cell -> Html Msg
renderCell index cell =
    let
        filling =
            case cell.fill of
                White ->
                    "white"

                Black ->
                    "black"
    in
    div
        [ class "cell"
        , class filling
        , onClick (SwitchFill index cell.fill)
        ]
        []


view : Model -> Html Msg
view model =
    div [ class "crossword" ]
        (List.indexedMap renderCell (Array.toList model))
