module Counter
  ( Action
  , Model
  , init
  , update
  , view
  , viewWithRemoveButton
  ) where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

type alias Model = Int

type Action = Increment | Decrement

init : Int -> Model
init val = val

update : Action -> Model -> Model
update action model =
  case action of
    Increment -> min (model + 1) 10
    Decrement -> max (model - 1) 0


view : Signal.Address Action -> Model -> Html
view address model =
  div []
  [ button [ onClick address Increment ] [ text "+" ]
  , div [ countStyle ] [ text (toString model) ]
  , button [ onClick address Decrement ] [ text "-" ]
  ]


type alias Context =
  { actions : Signal.Address Action
  , remove : Signal.Address ()
  }


viewWithRemoveButton : Context -> Model -> Html
viewWithRemoveButton context model =
  div []
    [ button [ onClick context.actions Increment ] [ text "+" ]
    , div [ countStyle ] [ text (toString model) ]
    , button [ onClick context.actions Decrement ] [ text "-" ]
    , div [] []
    , button [ onClick context.remove () ] [ text "X" ]
    ]


countStyle : Attribute
countStyle = style [("fontSize", "20px")]
