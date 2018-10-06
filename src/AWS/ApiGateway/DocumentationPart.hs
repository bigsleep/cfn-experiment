{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.DocumentationPart
    ( Location(..)
    , DocumentationPart(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Location = Location
    { _LocationPath :: Maybe Text
    , _LocationName :: Maybe Text
    , _LocationMethod :: Maybe Text
    , _LocationType :: Maybe Text
    , _LocationStatusCode :: Maybe Text
    } deriving (Show, Eq)

data DocumentationPart = DocumentationPart
    { _DocumentationPartLocation :: Location
    , _DocumentationPartRestApiId :: Text
    , _DocumentationPartProperties :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Location)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''DocumentationPart)

resourceJSON :: DocumentationPart -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::DocumentationPart" :: Text), "Properties" .= a ]
