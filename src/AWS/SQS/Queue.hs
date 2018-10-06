{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SQS.Queue
    ( Queue(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Queue = Queue
    { _QueueFifoQueue :: Maybe Bool
    , _QueueMessageRetentionPeriod :: Maybe Int
    , _QueueVisibilityTimeout :: Maybe Int
    , _QueueRedrivePolicy :: Maybe DA.Value
    , _QueueKmsMasterKeyId :: Maybe Text
    , _QueueQueueName :: Maybe Text
    , _QueueMaximumMessageSize :: Maybe Int
    , _QueueDelaySeconds :: Maybe Int
    , _QueueReceiveMessageWaitTimeSeconds :: Maybe Int
    , _QueueKmsDataKeyReusePeriodSeconds :: Maybe Int
    , _QueueContentBasedDeduplication :: Maybe Bool
    , _QueueTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Queue)

resourceJSON :: Queue -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SQS::Queue" :: Text), "Properties" .= a ]
