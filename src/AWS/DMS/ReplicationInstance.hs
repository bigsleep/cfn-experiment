{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.DMS.ReplicationInstance
    ( ReplicationInstance(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ReplicationInstance = ReplicationInstance
    { _ReplicationInstanceEngineVersion :: Maybe Text
    , _ReplicationInstancePubliclyAccessible :: Maybe Bool
    , _ReplicationInstanceAutoMinorVersionUpgrade :: Maybe Bool
    , _ReplicationInstanceAllowMajorVersionUpgrade :: Maybe Bool
    , _ReplicationInstanceReplicationSubnetGroupIdentifier :: Maybe Text
    , _ReplicationInstancePreferredMaintenanceWindow :: Maybe Text
    , _ReplicationInstanceKmsKeyId :: Maybe Text
    , _ReplicationInstanceAvailabilityZone :: Maybe Text
    , _ReplicationInstanceVpcSecurityGroupIds :: Maybe [Text]
    , _ReplicationInstanceMultiAZ :: Maybe Bool
    , _ReplicationInstanceAllocatedStorage :: Maybe Int
    , _ReplicationInstanceReplicationInstanceClass :: Text
    , _ReplicationInstanceReplicationInstanceIdentifier :: Maybe Text
    , _ReplicationInstanceTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''ReplicationInstance)

resourceJSON :: ReplicationInstance -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::DMS::ReplicationInstance" :: Text), "Properties" .= a ]
