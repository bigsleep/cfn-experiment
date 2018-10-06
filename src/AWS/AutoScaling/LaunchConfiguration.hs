{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.AutoScaling.LaunchConfiguration
    ( BlockDevice(..)
    , BlockDeviceMapping(..)
    , LaunchConfiguration(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data BlockDevice = BlockDevice
    { _BlockDeviceDeleteOnTermination :: Maybe Bool
    , _BlockDeviceVolumeSize :: Maybe Int
    , _BlockDeviceIops :: Maybe Int
    , _BlockDeviceEncrypted :: Maybe Bool
    , _BlockDeviceVolumeType :: Maybe Text
    , _BlockDeviceSnapshotId :: Maybe Text
    } deriving (Show, Eq)

data BlockDeviceMapping = BlockDeviceMapping
    { _BlockDeviceMappingVirtualName :: Maybe Text
    , _BlockDeviceMappingNoDevice :: Maybe Bool
    , _BlockDeviceMappingEbs :: Maybe BlockDevice
    , _BlockDeviceMappingDeviceName :: Text
    } deriving (Show, Eq)

data LaunchConfiguration = LaunchConfiguration
    { _LaunchConfigurationInstanceId :: Maybe Text
    , _LaunchConfigurationAssociatePublicIpAddress :: Maybe Bool
    , _LaunchConfigurationSecurityGroups :: Maybe [Text]
    , _LaunchConfigurationSpotPrice :: Maybe Text
    , _LaunchConfigurationInstanceMonitoring :: Maybe Bool
    , _LaunchConfigurationKeyName :: Maybe Text
    , _LaunchConfigurationClassicLinkVPCSecurityGroups :: Maybe [Text]
    , _LaunchConfigurationRamDiskId :: Maybe Text
    , _LaunchConfigurationKernelId :: Maybe Text
    , _LaunchConfigurationInstanceType :: Text
    , _LaunchConfigurationEbsOptimized :: Maybe Bool
    , _LaunchConfigurationUserData :: Maybe Text
    , _LaunchConfigurationClassicLinkVPCId :: Maybe Text
    , _LaunchConfigurationIamInstanceProfile :: Maybe Text
    , _LaunchConfigurationImageId :: Text
    , _LaunchConfigurationLaunchConfigurationName :: Maybe Text
    , _LaunchConfigurationPlacementTenancy :: Maybe Text
    , _LaunchConfigurationBlockDeviceMappings :: Maybe [BlockDeviceMapping]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''BlockDevice)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''BlockDeviceMapping)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''LaunchConfiguration)

resourceJSON :: LaunchConfiguration -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::AutoScaling::LaunchConfiguration" :: Text), "Properties" .= a ]
