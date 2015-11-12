{--
import CounterList exposing (init, update, view)

import StartApp.Simple exposing (start)

main =
  start { model = init
        , update = update
        , view = view }
--}

import Effects exposing (Never)
import Task exposing (Task)
import StartApp exposing (start)

import SpinSquarePair exposing (init, update, view)


app = start { init  = init
      , inputs = []
      , update = update
      , view = view
      }


main = app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
