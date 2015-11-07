module ImageViewer
  ( Action
  , Model
  , init
  , update
  , view
  ) where


import Json.Decode as Json exposing (..)
import Effects exposing (..)
import Task exposing (Task)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (src)
import Http exposing (..)


type alias Model =
  { topic : String
  , imgUrl : String
  }


init : String -> (Model, Effects Action)
init topic =
  ({ topic = topic, imgUrl = "" }, getImage topic )


type Action
  = RequestImage
  | NewImage (Maybe String)


update : Action -> Model -> (Model, Effects Action)
update msg model =
  case msg of
    RequestImage ->
      ( model
      , getImage model.topic
      )

    NewImage maybeUrl ->
      ( Model model.topic (Maybe.withDefault model.imgUrl maybeUrl)
      , Effects.none
      )


view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ img [ src model.imgUrl ] []
    , button [ onClick address RequestImage ] [text "Next!"]
    ]


getImage : String -> Effects Action
getImage topic =
  Http.get decodeImageUrl (topicUrl topic)
  |> Task.toMaybe
  |> Task.map NewImage
  |> Effects.task


topicUrl : String -> String
topicUrl topic =
  Http.url "http://api.giphy.com/v1/gifs/random"
  [ ("api_key", "dc6zaTOxFJmzC")
  , ("tag", topic)
  ]


decodeImageUrl : Json.Decoder String
decodeImageUrl =
  Json.at ["data", "image_url"] Json.string
