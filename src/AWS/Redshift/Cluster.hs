{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Redshift.Cluster
    ( LoggingProperties(..)
    , Cluster(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data LoggingProperties = LoggingProperties
    { _LoggingPropertiesS3KeyPrefix :: Maybe Text
    , _LoggingPropertiesBucketName :: Text
    } deriving (Show, Eq)

data Cluster = Cluster
    { _ClusterSnapshotIdentifier :: Maybe Text
    , _ClusterLoggingProperties :: Maybe LoggingProperties
    , _ClusterMasterUserPassword :: Text
    , _ClusterPubliclyAccessible :: Maybe Bool
    , _ClusterMasterUsername :: Text
    , _ClusterSnapshotClusterIdentifier :: Maybe Text
    , _ClusterHsmConfigurationIdentifier :: Maybe Text
    , _ClusterClusterSecurityGroups :: Maybe [Text]
    , _ClusterAutomatedSnapshotRetentionPeriod :: Maybe Int
    , _ClusterEncrypted :: Maybe Bool
    , _ClusterClusterSubnetGroupName :: Maybe Text
    , _ClusterClusterIdentifier :: Maybe Text
    , _ClusterHsmClientCertificateIdentifier :: Maybe Text
    , _ClusterNumberOfNodes :: Maybe Int
    , _ClusterElasticIp :: Maybe Text
    , _ClusterPreferredMaintenanceWindow :: Maybe Text
    , _ClusterKmsKeyId :: Maybe Text
    , _ClusterAvailabilityZone :: Maybe Text
    , _ClusterVpcSecurityGroupIds :: Maybe [Text]
    , _ClusterIamRoles :: Maybe [Text]
    , _ClusterClusterType :: Text
    , _ClusterClusterVersion :: Maybe Text
    , _ClusterOwnerAccount :: Maybe Text
    , _ClusterNodeType :: Text
    , _ClusterAllowVersionUpgrade :: Maybe Bool
    , _ClusterClusterParameterGroupName :: Maybe Text
    , _ClusterTags :: Maybe [Tag]
    , _ClusterPort :: Maybe Int
    , _ClusterDBName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''LoggingProperties)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Cluster)

resourceJSON :: Cluster -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Redshift::Cluster" :: Text), "Properties" .= a ]
