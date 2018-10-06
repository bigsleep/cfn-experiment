{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ElastiCache.CacheCluster
    ( CacheCluster(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data CacheCluster = CacheCluster
    { _CacheClusterEngineVersion :: Maybe Text
    , _CacheClusterCacheNodeType :: Text
    , _CacheClusterSnapshotArns :: Maybe [Text]
    , _CacheClusterAutoMinorVersionUpgrade :: Maybe Bool
    , _CacheClusterCacheParameterGroupName :: Maybe Text
    , _CacheClusterSnapshotWindow :: Maybe Text
    , _CacheClusterEngine :: Text
    , _CacheClusterPreferredAvailabilityZones :: Maybe [Text]
    , _CacheClusterPreferredMaintenanceWindow :: Maybe Text
    , _CacheClusterCacheSubnetGroupName :: Maybe Text
    , _CacheClusterPreferredAvailabilityZone :: Maybe Text
    , _CacheClusterVpcSecurityGroupIds :: Maybe [Text]
    , _CacheClusterSnapshotRetentionLimit :: Maybe Int
    , _CacheClusterClusterName :: Maybe Text
    , _CacheClusterAZMode :: Maybe Text
    , _CacheClusterSnapshotName :: Maybe Text
    , _CacheClusterNotificationTopicArn :: Maybe Text
    , _CacheClusterNumCacheNodes :: Int
    , _CacheClusterTags :: Maybe [Tag]
    , _CacheClusterPort :: Maybe Int
    , _CacheClusterCacheSecurityGroupNames :: Maybe [Text]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''CacheCluster)

resourceJSON :: CacheCluster -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ElastiCache::CacheCluster" :: Text), "Properties" .= a ]
