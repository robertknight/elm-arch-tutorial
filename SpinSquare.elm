module SpinSquare
  ( Action
  , Model
  , init
  , update
  , view
  ) where


import Easing exposing (ease, easeOutBounce, float)
import Effects exposing (..)
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Time exposing (Time, second)
import Svg exposing (rect, svg)
import Svg.Attributes exposing (fill, x, y, width, height, rx, ry, transform, viewBox)


type Action
  = Spin
  | Tick Time


type alias Model =
  { angle : Float
  , animationState : AnimationState
  }


type alias AnimationState =
  Maybe { prevClockTime : Time, elapsedTime : Time }


rotateStep = 90
duration = second


init : (Model, Effects Action)
init = ({angle = 0, animationState = Nothing}, Effects.none)


update : Action -> Model -> (Model, Effects Action)
update msg model =
  case msg of
    Spin ->
      case model.animationState of
        Nothing ->
          ( model, Effects.tick Tick )

        Just _ ->
          ( model, Effects.none )

    Tick clockTime ->
      let
        newElapsedTime =
          case model.animationState of
            Nothing ->
              0
            Just {elapsedTime, prevClockTime} ->
              elapsedTime + (clockTime - prevClockTime)
      in
        if newElapsedTime > duration then
          ( { angle = model.angle + rotateStep
            , animationState = Nothing
            }
          , Effects.none
          )
        else
          ( { angle = model.angle
            , animationState = Just { elapsedTime = newElapsedTime, prevClockTime = clockTime }
            }
          , Effects.tick Tick
          )


toOffset : AnimationState -> Float
toOffset animationState =
  case animationState of
    Nothing ->
      0
    Just {elapsedTime} ->
      ease easeOutBounce float 0 rotateStep duration elapsedTime



rotationAngle model =
  model.angle + toOffset(model.animationState)


view = viewAsSvg


viewAsSvg : Signal.Address Action -> Model -> Html
viewAsSvg address model =
  Svg.svg [ onClick address Spin
          , width "120"
          , height "120"
          , viewBox "0 0 120 120" ]
          [ rect
            [ x "10"
            , y "10"
            , width "100"
            , height "100"
            , transform ("rotate (" ++ toString(rotationAngle model) ++ ", 60, 60)")
            , fill "#ff4444"
            , rx "10"
            , ry "10"
            ]
            []
          ]


viewAsHtml : Signal.Address Action -> Model -> Html
viewAsHtml address model =
  div [
    onClick address Spin
  , style [
    ("backgroundColor", "green")
  , ("borderRadius", "5px")
  , ("width", "100px")
  , ("height", "100px")
  , ("transform", "rotateZ(" ++ toString(model.angle + toOffset(model.animationState)) ++ "deg)")]
  ] [text "Click me!"]
