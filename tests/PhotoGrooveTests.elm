module PhotoGrooveTests exposing (..)


import Json.Encode as Encode
import Json.Decode as Decode
import PhotoGroove
import Test exposing (..)
import Expect
import Fuzz exposing (int, string)


decoderTest : Test
decoderTest =
    fuzz2 string int "title defaults to (untitled)" <|
        \url size ->
            [ ( "url", Encode.string url)
            , ( "size", Encode.int size)
            ]
                |> Encode.object
                |> Decode.decodeValue PhotoGroove.photoDecoder
                |> Result.map .title
                |> Expect.equal (Ok "(untitled)")
        