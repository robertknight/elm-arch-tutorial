module SpinSquarePair
       ( Action
       , Model
       , init
       , update
       , view
       ) where


import Html exposing (..)
import Effects exposing (..)
import SpinSquare exposing (..)

type Action
  = Left SpinSquare.Action
  | Right SpinSquare.Action


type alias Model =
  { left : SpinSquare.Model
  , right : SpinSquare.Model
  }


init : (Model, Effects Action)
init =
  let (model, _) = SpinSquare.init in
  ({left = model, right = model}, Effects.none)


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    Left squareAction ->
      let (leftModel, leftFx) = SpinSquare.update squareAction model.left
      in
        ({model | left <- leftModel}, Effects.map (\modelAction -> Left modelAction) leftFx)
    Right squareAction ->
      let (rightModel, rightFx) = SpinSquare.update squareAction model.right
      in
        ({model | right <- rightModel}, Effects.map (\modelAction -> Right modelAction) rightFx)


view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ SpinSquare.view (Signal.forwardTo address Left) model.left
    , SpinSquare.view (Signal.forwardTo address Right) model.right
    ]
