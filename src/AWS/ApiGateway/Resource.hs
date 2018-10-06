{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.Resource
    ( Resource(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Resource = Resource
    { _ResourcePathPart :: Text
    , _ResourceRestApiId :: Text
    , _ResourceParentId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Resource)

resourceJSON :: Resource -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::Resource" :: Text), "Properties" .= a ]
