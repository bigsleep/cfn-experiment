{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IoT.Thing
    ( AttributePayload(..)
    , Thing(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data AttributePayload = AttributePayload
    { _AttributePayloadAttributes :: Maybe Map
    } deriving (Show, Eq)

data Thing = Thing
    { _ThingAttributePayload :: Maybe AttributePayload
    , _ThingThingName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''AttributePayload)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Thing)

resourceJSON :: Thing -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IoT::Thing" :: Text), "Properties" .= a ]
