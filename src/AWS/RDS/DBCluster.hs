{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.RDS.DBCluster
    ( ScalingConfiguration(..)
    , DBCluster(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ScalingConfiguration = ScalingConfiguration
    { _ScalingConfigurationSecondsBeforeAutoPause :: Maybe Int
    , _ScalingConfigurationAutoPause :: Maybe Bool
    , _ScalingConfigurationMaxCapacity :: Maybe Int
    , _ScalingConfigurationMinCapacity :: Maybe Int
    } deriving (Show, Eq)

data DBCluster = DBCluster
    { _DBClusterEngineVersion :: Maybe Text
    , _DBClusterStorageEncrypted :: Maybe Bool
    , _DBClusterDBClusterIdentifier :: Maybe Text
    , _DBClusterSnapshotIdentifier :: Maybe Text
    , _DBClusterMasterUserPassword :: Maybe Text
    , _DBClusterReplicationSourceIdentifier :: Maybe Text
    , _DBClusterMasterUsername :: Maybe Text
    , _DBClusterDBSubnetGroupName :: Maybe Text
    , _DBClusterEngine :: Text
    , _DBClusterPreferredMaintenanceWindow :: Maybe Text
    , _DBClusterAvailabilityZones :: Maybe [Text]
    , _DBClusterKmsKeyId :: Maybe Text
    , _DBClusterPreferredBackupWindow :: Maybe Text
    , _DBClusterBackupRetentionPeriod :: Maybe Int
    , _DBClusterVpcSecurityGroupIds :: Maybe [Text]
    , _DBClusterDatabaseName :: Maybe Text
    , _DBClusterDBClusterParameterGroupName :: Maybe Text
    , _DBClusterEngineMode :: Maybe Text
    , _DBClusterScalingConfiguration :: Maybe ScalingConfiguration
    , _DBClusterTags :: Maybe [Tag]
    , _DBClusterPort :: Maybe Int
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''ScalingConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''DBCluster)

resourceJSON :: DBCluster -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::RDS::DBCluster" :: Text), "Properties" .= a ]
