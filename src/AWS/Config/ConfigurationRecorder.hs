{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Config.ConfigurationRecorder
    ( RecordingGroup(..)
    , ConfigurationRecorder(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data RecordingGroup = RecordingGroup
    { _RecordingGroupAllSupported :: Maybe Bool
    , _RecordingGroupIncludeGlobalResourceTypes :: Maybe Bool
    , _RecordingGroupResourceTypes :: Maybe [Text]
    } deriving (Show, Eq)

data ConfigurationRecorder = ConfigurationRecorder
    { _ConfigurationRecorderName :: Maybe Text
    , _ConfigurationRecorderRecordingGroup :: Maybe RecordingGroup
    , _ConfigurationRecorderRoleARN :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''RecordingGroup)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''ConfigurationRecorder)

resourceJSON :: ConfigurationRecorder -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Config::ConfigurationRecorder" :: Text), "Properties" .= a ]
