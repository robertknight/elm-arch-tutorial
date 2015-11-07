module ImageViewerList
  ( Action
  , Model
  , init
  , update
  , view
  ) where


import Effects exposing (..)
import Html exposing (..)
import ImageViewer exposing (..)


type alias ID = Int


type Action
  = UpdateImage ImageViewer.Action ID


type alias Model
  = List (ID, ImageViewer.Model)


topicModels : List String -> List (ID, ImageViewer.Model, Effects ImageViewer.Action)
topicModels topics =
  let (_, viewerModelsAndFx) =
    List.foldr (\topic (nextID, acc) ->
     let (viewerModel, fx) = ImageViewer.init topic
     in  (nextID + 1, (nextID, viewerModel, fx) :: acc)
     ) (0, []) topics
   in
    viewerModelsAndFx


combineModelsAndFx : List (ID, ImageViewer.Model, Effects ImageViewer.Action) ->
  (Model, Effects Action)
combineModelsAndFx viewerModelsAndFx =
    ( List.map (\(id, viewerModel, fx) -> (id, viewerModel))
                      viewerModelsAndFx
    , Effects.batch (List.map (\(id, viewerModel, fx) ->
        Effects.map (\viewerAction -> UpdateImage viewerAction id) fx) viewerModelsAndFx)
    )


init : List String -> (Model, Effects Action)
init topics =
  combineModelsAndFx (topicModels topics)


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    UpdateImage viewerAction id ->
      let updatedModelsAndFx =
        List.map (\(viewerID, viewerModel) ->
            let (updatedModel, fx) = ImageViewer.update viewerAction viewerModel
            in (viewerID, updatedModel, fx)
          ) model
      in
        combineModelsAndFx updatedModelsAndFx


view : Signal.Address Action -> Model -> Html
view address model =
  div [] []
