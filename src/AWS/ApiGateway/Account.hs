{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.Account
    ( Account(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Account = Account
    { _AccountCloudWatchRoleArn :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Account)

resourceJSON :: Account -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::Account" :: Text), "Properties" .= a ]
