{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.AppSync.ApiKey
    ( ApiKey(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ApiKey = ApiKey
    { _ApiKeyApiId :: Text
    , _ApiKeyExpires :: Maybe Double
    , _ApiKeyDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''ApiKey)

resourceJSON :: ApiKey -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::AppSync::ApiKey" :: Text), "Properties" .= a ]
