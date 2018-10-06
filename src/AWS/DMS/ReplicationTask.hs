{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.DMS.ReplicationTask
    ( ReplicationTask(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ReplicationTask = ReplicationTask
    { _ReplicationTaskReplicationTaskSettings :: Maybe Text
    , _ReplicationTaskTargetEndpointArn :: Text
    , _ReplicationTaskReplicationTaskIdentifier :: Maybe Text
    , _ReplicationTaskSourceEndpointArn :: Text
    , _ReplicationTaskTableMappings :: Text
    , _ReplicationTaskMigrationType :: Text
    , _ReplicationTaskReplicationInstanceArn :: Text
    , _ReplicationTaskTags :: Maybe [Tag]
    , _ReplicationTaskCdcStartTime :: Maybe Double
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''ReplicationTask)

resourceJSON :: ReplicationTask -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::DMS::ReplicationTask" :: Text), "Properties" .= a ]
