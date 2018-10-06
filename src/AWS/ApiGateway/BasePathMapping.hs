{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.BasePathMapping
    ( BasePathMapping(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data BasePathMapping = BasePathMapping
    { _BasePathMappingStage :: Maybe Text
    , _BasePathMappingBasePath :: Maybe Text
    , _BasePathMappingDomainName :: Text
    , _BasePathMappingRestApiId :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''BasePathMapping)

resourceJSON :: BasePathMapping -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::BasePathMapping" :: Text), "Properties" .= a ]
