{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Config.DeliveryChannel
    ( ConfigSnapshotDeliveryProperties(..)
    , DeliveryChannel(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ConfigSnapshotDeliveryProperties = ConfigSnapshotDeliveryProperties
    { _ConfigSnapshotDeliveryPropertiesDeliveryFrequency :: Maybe Text
    } deriving (Show, Eq)

data DeliveryChannel = DeliveryChannel
    { _DeliveryChannelS3KeyPrefix :: Maybe Text
    , _DeliveryChannelSnsTopicARN :: Maybe Text
    , _DeliveryChannelName :: Maybe Text
    , _DeliveryChannelConfigSnapshotDeliveryProperties :: Maybe ConfigSnapshotDeliveryProperties
    , _DeliveryChannelS3BucketName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 33 } ''ConfigSnapshotDeliveryProperties)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''DeliveryChannel)

resourceJSON :: DeliveryChannel -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Config::DeliveryChannel" :: Text), "Properties" .= a ]
