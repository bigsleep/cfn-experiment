{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CloudFormation.WaitCondition
    ( WaitCondition(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data WaitCondition = WaitCondition
    { _WaitConditionHandle :: Text
    , _WaitConditionCount :: Maybe Int
    , _WaitConditionTimeout :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''WaitCondition)

resourceJSON :: WaitCondition -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CloudFormation::WaitCondition" :: Text), "Properties" .= a ]
