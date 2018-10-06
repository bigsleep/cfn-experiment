{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Logs.LogGroup
    ( LogGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data LogGroup = LogGroup
    { _LogGroupLogGroupName :: Maybe Text
    , _LogGroupRetentionInDays :: Maybe Int
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''LogGroup)

resourceJSON :: LogGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Logs::LogGroup" :: Text), "Properties" .= a ]
