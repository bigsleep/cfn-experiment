{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CloudTrail.Trail
    ( DataResource(..)
    , EventSelector(..)
    , Trail(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data DataResource = DataResource
    { _DataResourceValues :: Maybe [Text]
    , _DataResourceType :: Text
    } deriving (Show, Eq)

data EventSelector = EventSelector
    { _EventSelectorDataResources :: Maybe [DataResource]
    , _EventSelectorReadWriteType :: Maybe Text
    , _EventSelectorIncludeManagementEvents :: Maybe Bool
    } deriving (Show, Eq)

data Trail = Trail
    { _TrailS3KeyPrefix :: Maybe Text
    , _TrailEventSelectors :: Maybe [EventSelector]
    , _TrailSnsTopicName :: Maybe Text
    , _TrailEnableLogFileValidation :: Maybe Bool
    , _TrailCloudWatchLogsLogGroupArn :: Maybe Text
    , _TrailIsLogging :: Bool
    , _TrailKMSKeyId :: Maybe Text
    , _TrailTrailName :: Maybe Text
    , _TrailIncludeGlobalServiceEvents :: Maybe Bool
    , _TrailCloudWatchLogsRoleArn :: Maybe Text
    , _TrailS3BucketName :: Text
    , _TrailTags :: Maybe [Tag]
    , _TrailIsMultiRegionTrail :: Maybe Bool
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''DataResource)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''EventSelector)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Trail)

resourceJSON :: Trail -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CloudTrail::Trail" :: Text), "Properties" .= a ]
