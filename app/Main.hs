{-# LANGUAGE OverloadedStrings #-}
module Main where

import CFn (Attribute(..), AttributeType(..), PrimitiveType(..), Property(..),
            PropertyType(..), PropertyTypeDefinition(..),
            PropertyTypeDefinitions(..), ResourceTypeDefinition(..),
            Specification(..))
import qualified Data.ByteString as BS (readFile)
import qualified Data.ByteString.Lazy as BSL (toStrict)
import Data.Maybe (maybe)
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.IO as Text (putStr, readFile)
import qualified Data.Text.Lazy as TL (toStrict)
import Network.HTTP.Client
import Network.HTTP.Client.TLS
import Network.HTTP.Types.Status (statusCode)

import Data.Aeson (eitherDecodeStrict, (.=))
import qualified Data.Aeson as DA (object)
import qualified Data.HashMap.Strict as HM
import qualified Text.EDE as EDE (eitherParseFile, eitherRender, fromPairs)

main :: IO ()
main = do
    {-
    manager <- newManager tlsManagerSettings

    request <- parseRequest "https://d33vqc0rt9ld30.cloudfront.net/latest/gzip/CloudFormationResourceSpecification.json"
    response <- httpLbs request manager

    putStrLn $ "The status code was: " ++ show (statusCode $ responseStatus response)
    let x = eitherDecodeStrict . BSL.toStrict $ responseBody response
    print (x :: Either String Specification)
    -}
    source <- BS.readFile "resource-specification.json"
    spec <- either error return $ eitherDecodeStrict source
    let propertyDefinitions = unPropertyTypeDefinitions . specificationPropertyTypes $ spec
        resourceDefinitions = specificationResourceTypes spec

    t <- EDE.eitherParseFile "template/code.ede"

    mapM_ (renderResource t propertyDefinitions) . HM.toList $ resourceDefinitions

    where

    renderPropertyDefinitions t (k, ds) = do
        let env = EDE.fromPairs
                [ "Module" .= Text.replace "::" "." k
                , "PropertyDefinitions" .= map propertyDefToJSON ds
                ]
        either error (Text.putStr . TL.toStrict)  $ t >>= (`EDE.eitherRender` env)

    renderResource t ps (k, resource) =  do
        let ds = HM.lookupDefault [] k ps
            env = EDE.fromPairs
                [ "Module" .= Text.replace "::" "." k
                , "ResourceName" .= snd (Text.breakOnEnd "::" k)
                , "PropertyDefinitions" .= map propertyDefToJSON ds
                , "ResourceDefinition" .= resourceToJSON resource
                ]
        either error (Text.putStr . TL.toStrict)  $ t >>= (`EDE.eitherRender` env)

    renderType True (PropertyType t) = t
    renderType False (PropertyType t) = Text.concat ["Maybe ", t]
    renderType True (PropertyTypePrimitive t) = renderPrimitiveType t
    renderType False (PropertyTypePrimitive t) = Text.concat ["Maybe ", renderPrimitiveType t]
    renderType True (PropertyTypeList t) = Text.concat ["[", t, "]"]
    renderType False (PropertyTypeList t) = Text.concat ["Maybe [", t, "]"]
    renderType True (PropertyTypePrimitiveList t) = Text.concat ["[", renderPrimitiveType t, "]"]
    renderType False (PropertyTypePrimitiveList t) = Text.concat ["Maybe [", renderPrimitiveType t, "]"]

    renderPrimitiveType PrimBoolean   = "Bool"
    renderPrimitiveType PrimDouble    = "Double"
    renderPrimitiveType PrimInteger   = "Int"
    renderPrimitiveType PrimJson      = "Value"
    renderPrimitiveType PrimLong      = "Integer"
    renderPrimitiveType PrimString    = "Text"
    renderPrimitiveType PrimTimestamp = "Text"

    renderAttributeType (AttributeTypePrimitive t) = renderPrimitiveType t
    renderAttributeType (AttributeTypePrimitiveList t) = Text.concat ["[", renderPrimitiveType t, "]"]

    attributeToJSON (k, Attribute t) =
        DA.object
        [ "Name" .= k
        , "Type" .= renderAttributeType t
        ]

    propertyToJSON (k, Property t doc required update) =
        DA.object
        [ "Name" .= k
        , "Type" .= renderType required t
        , "Reuqired" .= required
        , "UpdateType" .= update
        ]
    propertyDefToJSON (PropertyTypeDefinition ns n doc ps) =
        DA.object
        [ "Name" .= n
        , "NameSpace" .= ns
        , "Documentation" .= doc
        , "Properties" .= map propertyToJSON (HM.toList ps)
        ]

    resourceToJSON (ResourceTypeDefinition doc attributes properties) =
        DA.object
        [ "Documentation" .= doc
        , "Attributes" .= maybe [] (map attributeToJSON . HM.toList) attributes
        , "Properties" .= map propertyToJSON (HM.toList properties)
        ]
