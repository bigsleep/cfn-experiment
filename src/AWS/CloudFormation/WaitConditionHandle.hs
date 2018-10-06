{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CloudFormation.WaitConditionHandle
    ( WaitConditionHandle(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data WaitConditionHandle = WaitConditionHandle
    {} deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''WaitConditionHandle)

resourceJSON :: WaitConditionHandle -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CloudFormation::WaitConditionHandle" :: Text), "Properties" .= a ]
