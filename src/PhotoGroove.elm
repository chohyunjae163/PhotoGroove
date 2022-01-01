module PhotoGroove exposing (main)

import Html exposing (div, h1,img, text)
import Html.Attributes exposing(..)
import Html.Events exposing (onClick)
import Browser
urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"


--tranlates the current model into a desired DOM structure
view :  { photos : List { url : String }, selectedUrl : String} ->  Html.Html { description : String, data : String }
view model =
  div [class "content" ]
      [ h1 [] [text "Photo Groove"]
      , div [ id "thumbnails" ] 
            (List.map (viewThumbnail model.selectedUrl) model.photos)
        , img
            [ class "large"
            , src (urlPrefix ++ "large/" ++ model.selectedUrl)
            ]
            []
      ]


--viewThumbnail : String -> { url : String } -> Html.Html msg
viewThumbnail : String -> { url : String } -> Html.Html { description : String, data : String }
viewThumbnail selectedUrl thumb =
    img
        [ src (urlPrefix ++ thumb.url)
        , classList [ ( "selected", selectedUrl == thumb.url ) ]
        , onClick { description = "ClickedPhoto", data = thumb.url }
        ]
         []


initialModel : { photos : List { url : String }, selectedUrl : String}
initialModel =
    { photos = 
        [ {url = "1.jpeg"}
        , {url = "2.jpeg"}
        , {url = "3.jpeg"}
        ]
    , selectedUrl = "1.jpeg"    
    }


--update : {  description : String, data : b } -> { selectedUrl : b } -> { selectedUrl : b }
update msg model =
    if msg.description == "ClickedPhoto" then
        { model | selectedUrl = msg.data}

    else
        model

--main : Html.Html msg
main : Program () { photos : List { url : String }, selectedUrl : String } { description : String, data : String }
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }