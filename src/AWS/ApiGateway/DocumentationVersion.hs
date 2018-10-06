{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.DocumentationVersion
    ( DocumentationVersion(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data DocumentationVersion = DocumentationVersion
    { _DocumentationVersionDocumentationVersion :: Text
    , _DocumentationVersionRestApiId :: Text
    , _DocumentationVersionDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''DocumentationVersion)

resourceJSON :: DocumentationVersion -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::DocumentationVersion" :: Text), "Properties" .= a ]
