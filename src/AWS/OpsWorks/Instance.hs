{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.OpsWorks.Instance
    ( TimeBasedAutoScaling(..)
    , EbsBlockDevice(..)
    , BlockDeviceMapping(..)
    , Instance(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data TimeBasedAutoScaling = TimeBasedAutoScaling
    { _TimeBasedAutoScalingThursday :: Maybe Map
    , _TimeBasedAutoScalingWednesday :: Maybe Map
    , _TimeBasedAutoScalingSaturday :: Maybe Map
    , _TimeBasedAutoScalingMonday :: Maybe Map
    , _TimeBasedAutoScalingFriday :: Maybe Map
    , _TimeBasedAutoScalingSunday :: Maybe Map
    , _TimeBasedAutoScalingTuesday :: Maybe Map
    } deriving (Show, Eq)

data EbsBlockDevice = EbsBlockDevice
    { _EbsBlockDeviceDeleteOnTermination :: Maybe Bool
    , _EbsBlockDeviceVolumeSize :: Maybe Int
    , _EbsBlockDeviceIops :: Maybe Int
    , _EbsBlockDeviceVolumeType :: Maybe Text
    , _EbsBlockDeviceSnapshotId :: Maybe Text
    } deriving (Show, Eq)

data BlockDeviceMapping = BlockDeviceMapping
    { _BlockDeviceMappingVirtualName :: Maybe Text
    , _BlockDeviceMappingNoDevice :: Maybe Text
    , _BlockDeviceMappingEbs :: Maybe EbsBlockDevice
    , _BlockDeviceMappingDeviceName :: Maybe Text
    } deriving (Show, Eq)

data Instance = Instance
    { _InstanceInstallUpdatesOnBoot :: Maybe Bool
    , _InstanceVirtualizationType :: Maybe Text
    , _InstanceElasticIps :: Maybe [Text]
    , _InstanceHostname :: Maybe Text
    , _InstanceSshKeyName :: Maybe Text
    , _InstanceAgentVersion :: Maybe Text
    , _InstanceTimeBasedAutoScaling :: Maybe TimeBasedAutoScaling
    , _InstanceSubnetId :: Maybe Text
    , _InstanceInstanceType :: Text
    , _InstanceEbsOptimized :: Maybe Bool
    , _InstanceOs :: Maybe Text
    , _InstanceAvailabilityZone :: Maybe Text
    , _InstanceTenancy :: Maybe Text
    , _InstanceAutoScalingType :: Maybe Text
    , _InstanceLayerIds :: [Text]
    , _InstanceArchitecture :: Maybe Text
    , _InstanceAmiId :: Maybe Text
    , _InstanceVolumes :: Maybe [Text]
    , _InstanceStackId :: Text
    , _InstanceRootDeviceType :: Maybe Text
    , _InstanceBlockDeviceMappings :: Maybe [BlockDeviceMapping]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''TimeBasedAutoScaling)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''EbsBlockDevice)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''BlockDeviceMapping)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Instance)

resourceJSON :: Instance -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::OpsWorks::Instance" :: Text), "Properties" .= a ]
