{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IAM.AccessKey
    ( AccessKey(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data AccessKey = AccessKey
    { _AccessKeyStatus :: Maybe Text
    , _AccessKeySerial :: Maybe Int
    , _AccessKeyUserName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''AccessKey)

resourceJSON :: AccessKey -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IAM::AccessKey" :: Text), "Properties" .= a ]
