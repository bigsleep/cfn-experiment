{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Elasticsearch.Domain
    ( SnapshotOptions(..)
    , EncryptionAtRestOptions(..)
    , VPCOptions(..)
    , EBSOptions(..)
    , ElasticsearchClusterConfig(..)
    , Domain(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SnapshotOptions = SnapshotOptions
    { _SnapshotOptionsAutomatedSnapshotStartHour :: Maybe Int
    } deriving (Show, Eq)

data EncryptionAtRestOptions = EncryptionAtRestOptions
    { _EncryptionAtRestOptionsEnabled :: Maybe Bool
    , _EncryptionAtRestOptionsKmsKeyId :: Maybe Text
    } deriving (Show, Eq)

data VPCOptions = VPCOptions
    { _VPCOptionsSecurityGroupIds :: Maybe [Text]
    , _VPCOptionsSubnetIds :: Maybe [Text]
    } deriving (Show, Eq)

data EBSOptions = EBSOptions
    { _EBSOptionsVolumeSize :: Maybe Int
    , _EBSOptionsIops :: Maybe Int
    , _EBSOptionsVolumeType :: Maybe Text
    , _EBSOptionsEBSEnabled :: Maybe Bool
    } deriving (Show, Eq)

data ElasticsearchClusterConfig = ElasticsearchClusterConfig
    { _ElasticsearchClusterConfigDedicatedMasterCount :: Maybe Int
    , _ElasticsearchClusterConfigDedicatedMasterType :: Maybe Text
    , _ElasticsearchClusterConfigDedicatedMasterEnabled :: Maybe Bool
    , _ElasticsearchClusterConfigInstanceCount :: Maybe Int
    , _ElasticsearchClusterConfigZoneAwarenessEnabled :: Maybe Bool
    , _ElasticsearchClusterConfigInstanceType :: Maybe Text
    } deriving (Show, Eq)

data Domain = Domain
    { _DomainEBSOptions :: Maybe EBSOptions
    , _DomainAccessPolicies :: Maybe DA.Value
    , _DomainElasticsearchClusterConfig :: Maybe ElasticsearchClusterConfig
    , _DomainSnapshotOptions :: Maybe SnapshotOptions
    , _DomainDomainName :: Maybe Text
    , _DomainEncryptionAtRestOptions :: Maybe EncryptionAtRestOptions
    , _DomainVPCOptions :: Maybe VPCOptions
    , _DomainAdvancedOptions :: Maybe Map
    , _DomainTags :: Maybe [Tag]
    , _DomainElasticsearchVersion :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''SnapshotOptions)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''EncryptionAtRestOptions)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''VPCOptions)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''EBSOptions)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 27 } ''ElasticsearchClusterConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Domain)

resourceJSON :: Domain -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Elasticsearch::Domain" :: Text), "Properties" .= a ]
