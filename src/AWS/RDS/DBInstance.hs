{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.RDS.DBInstance
    ( DBInstance(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data DBInstance = DBInstance
    { _DBInstanceEngineVersion :: Maybe Text
    , _DBInstanceDBSecurityGroups :: Maybe [Text]
    , _DBInstanceStorageEncrypted :: Maybe Bool
    , _DBInstanceDBClusterIdentifier :: Maybe Text
    , _DBInstanceMasterUserPassword :: Maybe Text
    , _DBInstancePubliclyAccessible :: Maybe Bool
    , _DBInstanceAutoMinorVersionUpgrade :: Maybe Bool
    , _DBInstanceMasterUsername :: Maybe Text
    , _DBInstanceSourceRegion :: Maybe Text
    , _DBInstanceDBSubnetGroupName :: Maybe Text
    , _DBInstanceMonitoringRoleArn :: Maybe Text
    , _DBInstanceIops :: Maybe Int
    , _DBInstanceAllowMajorVersionUpgrade :: Maybe Bool
    , _DBInstanceDomain :: Maybe Text
    , _DBInstanceMonitoringInterval :: Maybe Int
    , _DBInstanceEngine :: Maybe Text
    , _DBInstanceSourceDBInstanceIdentifier :: Maybe Text
    , _DBInstanceDBSnapshotIdentifier :: Maybe Text
    , _DBInstanceDBInstanceClass :: Text
    , _DBInstanceLicenseModel :: Maybe Text
    , _DBInstancePreferredMaintenanceWindow :: Maybe Text
    , _DBInstanceDBInstanceIdentifier :: Maybe Text
    , _DBInstanceCharacterSetName :: Maybe Text
    , _DBInstanceKmsKeyId :: Maybe Text
    , _DBInstanceDBParameterGroupName :: Maybe Text
    , _DBInstancePreferredBackupWindow :: Maybe Text
    , _DBInstanceVPCSecurityGroups :: Maybe [Text]
    , _DBInstanceAvailabilityZone :: Maybe Text
    , _DBInstanceBackupRetentionPeriod :: Maybe Text
    , _DBInstanceMultiAZ :: Maybe Bool
    , _DBInstanceAllocatedStorage :: Maybe Text
    , _DBInstanceOptionGroupName :: Maybe Text
    , _DBInstanceCopyTagsToSnapshot :: Maybe Bool
    , _DBInstanceTimezone :: Maybe Text
    , _DBInstanceDomainIAMRoleName :: Maybe Text
    , _DBInstanceTags :: Maybe [Tag]
    , _DBInstancePort :: Maybe Text
    , _DBInstanceStorageType :: Maybe Text
    , _DBInstanceDBName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''DBInstance)

resourceJSON :: DBInstance -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::RDS::DBInstance" :: Text), "Properties" .= a ]
