module Main exposing (..)

import Browser exposing (element)
import Element
import Element.Background
import Element.Font
import Html exposing (Html)
import Html.Attributes exposing (src)


main : Html msg
main =
    viewLayout


blueColor : Element.Color
blueColor =
    Element.rgb 0 100 100


viewLayout : Html msg
viewLayout =
    Element.layoutWith
        { options = []
        }
        [ Element.Font.bold
        , Element.Background.color (Element.rgb255 160 100 130)
        , Element.padding 30
        ]
        (Element.column []
            [ heading
            , description
            , image
            ]
        )


heading : Element.Element msg
heading =
    Element.paragraph
        [ Element.Font.color blueColor
        ]
        [ Element.text "welcome"
        ]


description : Element.Element msg
description =
    Element.paragraph [ Element.Font.color (Element.rgb 255 255 255) ]
        [ Element.text "This is a web page"
        ]


image : Element.Element msg
image =
    Element.image [ Element.width Element.fill ]
        { src = "https://images.pexels.com/photos/159866/books-book-pages-read-literature-159866.jpeg?cs=srgb&dl=pexels-pixabay-159866.jpg&fm=jpg"
        , description = "Book"
        }
