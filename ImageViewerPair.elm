module ImageViewerPair
  ( Model
  , Action
  , init
  , update
  , view
  ) where


import Effects exposing (..)
import Html exposing (..)
import ImageViewer exposing (..)

type alias Model =
  { left: ImageViewer.Model
  , right: ImageViewer.Model
  }

type Action
  = Left ImageViewer.Action
  | Right ImageViewer.Action


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    Left msg ->
      let
        (left, fx) = ImageViewer.update msg model.left
      in
        ( Model left model.right
        , Effects.map Left fx
        )

    Right msg ->
      let
        (right, fx) = ImageViewer.update msg model.right
      in
        ( Model model.left right
        , Effects.map Right fx
        )


init : String -> String -> (Model, Effects Action)
init leftTopic rightTopic =
  let
    (left, leftFx) = ImageViewer.init leftTopic
    (right, rightFx) = ImageViewer.init rightTopic
  in
    ( Model left right
    , Effects.batch
      [ Effects.map Left leftFx
      , Effects.map Right rightFx
      ]
    )


view : Signal.Address Action -> Model -> Html
view address model =
  div []
  [ ImageViewer.view (Signal.forwardTo address Left) model.left
  , ImageViewer.view (Signal.forwardTo address Right) model.right
  ]
