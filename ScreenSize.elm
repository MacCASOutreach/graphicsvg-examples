import GraphicSVG exposing (..)
import GraphicSVG.App exposing (appWithTick, AppWithTick, GetKeyState)
import Url exposing (Url)
import Browser exposing (UrlRequest)
import Browser.Events
import Browser.Dom exposing (getViewport)
import Task

-- This example must be viewed by elm reactor or another web server, not directly after using elm-make

type alias Model = 
    { time : Float
    , w : Int
    , h : Int
    }

type Msg = 
      Tick Float GetKeyState
    | OnUrlChange Url
    | OnUrlRequest UrlRequest
    | OnResize Int Int

main : AppWithTick () Model Msg
main = appWithTick Tick
    { init = \_ url key -> 
        (init, Task.perform (\vp -> OnResize (round vp.viewport.width) (round vp.viewport.height)) getViewport)
        -- get initial screen width
    , update = update
    , view = \model -> { body = view model, title = title model }
    , subscriptions = \_ -> Browser.Events.onResize OnResize -- subscribe to any other changes in screen size
    , onUrlRequest = OnUrlRequest
    , onUrlChange = OnUrlChange
    }

init : Model
init =
        {
            time = 0
        ,   w = 0
        ,   h = 0
        }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of 
        Tick t (_,(_,h),_) -> ( { model | time = t }, Cmd.none )
        OnUrlChange _ -> ( model, Cmd.none )
        OnUrlRequest _ -> ( model, Cmd.none )
        OnResize w h -> ( { model | w = w, h = h }, Cmd.none) -- store new screen size in the model

title : Model -> String
title model =
    "App with Tick Example"

view : Model -> Collage Msg
view model = collage (toFloat model.w) (toFloat model.h)
    [ rect (toFloat model.w) (toFloat model.h) |> filled (hsl model.time 0.5 0.5)
    , text ("Screen size: " ++ String.fromInt model.w ++ "," ++ String.fromInt model.h) |> centered |> filled black
    ]

biggerButton = 
    group 
        [ circle 5 |> filled darkGrey
        , rect 8 1 |> filled white 
        , rect 1 8 |> filled white 
        ]
smallerButton = 
    group 
        [ circle 5 |> filled darkGrey
        , rect 8 1 |> filled white
        ]