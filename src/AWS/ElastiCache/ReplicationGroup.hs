{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ElastiCache.ReplicationGroup
    ( NodeGroupConfiguration(..)
    , ReplicationGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data NodeGroupConfiguration = NodeGroupConfiguration
    { _NodeGroupConfigurationSlots :: Maybe Text
    , _NodeGroupConfigurationReplicaCount :: Maybe Int
    , _NodeGroupConfigurationPrimaryAvailabilityZone :: Maybe Text
    , _NodeGroupConfigurationReplicaAvailabilityZones :: Maybe [Text]
    , _NodeGroupConfigurationNodeGroupId :: Maybe Text
    } deriving (Show, Eq)

data ReplicationGroup = ReplicationGroup
    { _ReplicationGroupAutomaticFailoverEnabled :: Maybe Bool
    , _ReplicationGroupEngineVersion :: Maybe Text
    , _ReplicationGroupCacheNodeType :: Maybe Text
    , _ReplicationGroupNodeGroupConfiguration :: Maybe [NodeGroupConfiguration]
    , _ReplicationGroupSnapshottingClusterId :: Maybe Text
    , _ReplicationGroupAtRestEncryptionEnabled :: Maybe Bool
    , _ReplicationGroupSecurityGroupIds :: Maybe [Text]
    , _ReplicationGroupSnapshotArns :: Maybe [Text]
    , _ReplicationGroupAutoMinorVersionUpgrade :: Maybe Bool
    , _ReplicationGroupCacheParameterGroupName :: Maybe Text
    , _ReplicationGroupReplicationGroupDescription :: Text
    , _ReplicationGroupTransitEncryptionEnabled :: Maybe Bool
    , _ReplicationGroupSnapshotWindow :: Maybe Text
    , _ReplicationGroupAuthToken :: Maybe Text
    , _ReplicationGroupPrimaryClusterId :: Maybe Text
    , _ReplicationGroupEngine :: Maybe Text
    , _ReplicationGroupPreferredMaintenanceWindow :: Maybe Text
    , _ReplicationGroupCacheSubnetGroupName :: Maybe Text
    , _ReplicationGroupNumNodeGroups :: Maybe Int
    , _ReplicationGroupSnapshotRetentionLimit :: Maybe Int
    , _ReplicationGroupReplicasPerNodeGroup :: Maybe Int
    , _ReplicationGroupNumCacheClusters :: Maybe Int
    , _ReplicationGroupPreferredCacheClusterAZs :: Maybe [Text]
    , _ReplicationGroupSnapshotName :: Maybe Text
    , _ReplicationGroupReplicationGroupId :: Maybe Text
    , _ReplicationGroupNotificationTopicArn :: Maybe Text
    , _ReplicationGroupTags :: Maybe [Tag]
    , _ReplicationGroupPort :: Maybe Int
    , _ReplicationGroupCacheSecurityGroupNames :: Maybe [Text]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 23 } ''NodeGroupConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''ReplicationGroup)

resourceJSON :: ReplicationGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ElastiCache::ReplicationGroup" :: Text), "Properties" .= a ]
