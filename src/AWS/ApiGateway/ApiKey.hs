{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.ApiKey
    ( StageKey(..)
    , ApiKey(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data StageKey = StageKey
    { _StageKeyRestApiId :: Maybe Text
    , _StageKeyStageName :: Maybe Text
    } deriving (Show, Eq)

data ApiKey = ApiKey
    { _ApiKeyEnabled :: Maybe Bool
    , _ApiKeyCustomerId :: Maybe Text
    , _ApiKeyGenerateDistinctId :: Maybe Bool
    , _ApiKeyName :: Maybe Text
    , _ApiKeyStageKeys :: Maybe [StageKey]
    , _ApiKeyDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''StageKey)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''ApiKey)

resourceJSON :: ApiKey -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::ApiKey" :: Text), "Properties" .= a ]
