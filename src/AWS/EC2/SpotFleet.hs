{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.SpotFleet
    ( EbsBlockDevice(..)
    , TargetGroup(..)
    , ClassicLoadBalancer(..)
    , InstanceIpv6Address(..)
    , SpotFleetLaunchSpecification(..)
    , FleetLaunchTemplateSpecification(..)
    , LoadBalancersConfig(..)
    , GroupIdentifier(..)
    , SpotPlacement(..)
    , SpotFleetTagSpecification(..)
    , SpotFleetMonitoring(..)
    , LaunchTemplateOverrides(..)
    , BlockDeviceMapping(..)
    , SpotFleetRequestConfigData(..)
    , IamInstanceProfileSpecification(..)
    , TargetGroupsConfig(..)
    , LaunchTemplateConfig(..)
    , ClassicLoadBalancersConfig(..)
    , PrivateIpAddressSpecification(..)
    , InstanceNetworkInterfaceSpecification(..)
    , SpotFleet(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data EbsBlockDevice = EbsBlockDevice
    { _EbsBlockDeviceDeleteOnTermination :: Maybe Bool
    , _EbsBlockDeviceVolumeSize :: Maybe Int
    , _EbsBlockDeviceIops :: Maybe Int
    , _EbsBlockDeviceEncrypted :: Maybe Bool
    , _EbsBlockDeviceVolumeType :: Maybe Text
    , _EbsBlockDeviceSnapshotId :: Maybe Text
    } deriving (Show, Eq)

data TargetGroup = TargetGroup
    { _TargetGroupArn :: Text
    } deriving (Show, Eq)

data ClassicLoadBalancer = ClassicLoadBalancer
    { _ClassicLoadBalancerName :: Text
    } deriving (Show, Eq)

data InstanceIpv6Address = InstanceIpv6Address
    { _InstanceIpv6AddressIpv6Address :: Text
    } deriving (Show, Eq)

data SpotFleetLaunchSpecification = SpotFleetLaunchSpecification
    { _SpotFleetLaunchSpecificationSecurityGroups :: Maybe [GroupIdentifier]
    , _SpotFleetLaunchSpecificationSpotPrice :: Maybe Text
    , _SpotFleetLaunchSpecificationWeightedCapacity :: Maybe Double
    , _SpotFleetLaunchSpecificationKeyName :: Maybe Text
    , _SpotFleetLaunchSpecificationNetworkInterfaces :: Maybe [InstanceNetworkInterfaceSpecification]
    , _SpotFleetLaunchSpecificationRamdiskId :: Maybe Text
    , _SpotFleetLaunchSpecificationSubnetId :: Maybe Text
    , _SpotFleetLaunchSpecificationKernelId :: Maybe Text
    , _SpotFleetLaunchSpecificationInstanceType :: Text
    , _SpotFleetLaunchSpecificationEbsOptimized :: Maybe Bool
    , _SpotFleetLaunchSpecificationUserData :: Maybe Text
    , _SpotFleetLaunchSpecificationMonitoring :: Maybe SpotFleetMonitoring
    , _SpotFleetLaunchSpecificationTagSpecifications :: Maybe [SpotFleetTagSpecification]
    , _SpotFleetLaunchSpecificationIamInstanceProfile :: Maybe IamInstanceProfileSpecification
    , _SpotFleetLaunchSpecificationImageId :: Text
    , _SpotFleetLaunchSpecificationBlockDeviceMappings :: Maybe [BlockDeviceMapping]
    , _SpotFleetLaunchSpecificationPlacement :: Maybe SpotPlacement
    } deriving (Show, Eq)

data FleetLaunchTemplateSpecification = FleetLaunchTemplateSpecification
    { _FleetLaunchTemplateSpecificationLaunchTemplateName :: Maybe Text
    , _FleetLaunchTemplateSpecificationLaunchTemplateId :: Maybe Text
    , _FleetLaunchTemplateSpecificationVersion :: Text
    } deriving (Show, Eq)

data LoadBalancersConfig = LoadBalancersConfig
    { _LoadBalancersConfigClassicLoadBalancersConfig :: Maybe ClassicLoadBalancersConfig
    , _LoadBalancersConfigTargetGroupsConfig :: Maybe TargetGroupsConfig
    } deriving (Show, Eq)

data GroupIdentifier = GroupIdentifier
    { _GroupIdentifierGroupId :: Text
    } deriving (Show, Eq)

data SpotPlacement = SpotPlacement
    { _SpotPlacementAvailabilityZone :: Maybe Text
    , _SpotPlacementTenancy :: Maybe Text
    , _SpotPlacementGroupName :: Maybe Text
    } deriving (Show, Eq)

data SpotFleetTagSpecification = SpotFleetTagSpecification
    { _SpotFleetTagSpecificationResourceType :: Maybe Text
    } deriving (Show, Eq)

data SpotFleetMonitoring = SpotFleetMonitoring
    { _SpotFleetMonitoringEnabled :: Maybe Bool
    } deriving (Show, Eq)

data LaunchTemplateOverrides = LaunchTemplateOverrides
    { _LaunchTemplateOverridesSpotPrice :: Maybe Text
    , _LaunchTemplateOverridesWeightedCapacity :: Maybe Double
    , _LaunchTemplateOverridesSubnetId :: Maybe Text
    , _LaunchTemplateOverridesInstanceType :: Maybe Text
    , _LaunchTemplateOverridesAvailabilityZone :: Maybe Text
    } deriving (Show, Eq)

data BlockDeviceMapping = BlockDeviceMapping
    { _BlockDeviceMappingVirtualName :: Maybe Text
    , _BlockDeviceMappingNoDevice :: Maybe Text
    , _BlockDeviceMappingEbs :: Maybe EbsBlockDevice
    , _BlockDeviceMappingDeviceName :: Text
    } deriving (Show, Eq)

data SpotFleetRequestConfigData = SpotFleetRequestConfigData
    { _SpotFleetRequestConfigDataIamFleetRole :: Text
    , _SpotFleetRequestConfigDataInstanceInterruptionBehavior :: Maybe Text
    , _SpotFleetRequestConfigDataTargetCapacity :: Int
    , _SpotFleetRequestConfigDataSpotPrice :: Maybe Text
    , _SpotFleetRequestConfigDataLoadBalancersConfig :: Maybe LoadBalancersConfig
    , _SpotFleetRequestConfigDataExcessCapacityTerminationPolicy :: Maybe Text
    , _SpotFleetRequestConfigDataLaunchTemplateConfigs :: Maybe [LaunchTemplateConfig]
    , _SpotFleetRequestConfigDataValidUntil :: Maybe Text
    , _SpotFleetRequestConfigDataTerminateInstancesWithExpiration :: Maybe Bool
    , _SpotFleetRequestConfigDataType :: Maybe Text
    , _SpotFleetRequestConfigDataValidFrom :: Maybe Text
    , _SpotFleetRequestConfigDataReplaceUnhealthyInstances :: Maybe Bool
    , _SpotFleetRequestConfigDataLaunchSpecifications :: Maybe [SpotFleetLaunchSpecification]
    , _SpotFleetRequestConfigDataAllocationStrategy :: Maybe Text
    } deriving (Show, Eq)

data IamInstanceProfileSpecification = IamInstanceProfileSpecification
    { _IamInstanceProfileSpecificationArn :: Maybe Text
    } deriving (Show, Eq)

data TargetGroupsConfig = TargetGroupsConfig
    { _TargetGroupsConfigTargetGroups :: [TargetGroup]
    } deriving (Show, Eq)

data LaunchTemplateConfig = LaunchTemplateConfig
    { _LaunchTemplateConfigOverrides :: Maybe [LaunchTemplateOverrides]
    , _LaunchTemplateConfigLaunchTemplateSpecification :: Maybe FleetLaunchTemplateSpecification
    } deriving (Show, Eq)

data ClassicLoadBalancersConfig = ClassicLoadBalancersConfig
    { _ClassicLoadBalancersConfigClassicLoadBalancers :: [ClassicLoadBalancer]
    } deriving (Show, Eq)

data PrivateIpAddressSpecification = PrivateIpAddressSpecification
    { _PrivateIpAddressSpecificationPrimary :: Maybe Bool
    , _PrivateIpAddressSpecificationPrivateIpAddress :: Text
    } deriving (Show, Eq)

data InstanceNetworkInterfaceSpecification = InstanceNetworkInterfaceSpecification
    { _InstanceNetworkInterfaceSpecificationGroups :: Maybe [Text]
    , _InstanceNetworkInterfaceSpecificationPrivateIpAddresses :: Maybe [PrivateIpAddressSpecification]
    , _InstanceNetworkInterfaceSpecificationDeleteOnTermination :: Maybe Bool
    , _InstanceNetworkInterfaceSpecificationAssociatePublicIpAddress :: Maybe Bool
    , _InstanceNetworkInterfaceSpecificationNetworkInterfaceId :: Maybe Text
    , _InstanceNetworkInterfaceSpecificationSubnetId :: Maybe Text
    , _InstanceNetworkInterfaceSpecificationIpv6AddressCount :: Maybe Int
    , _InstanceNetworkInterfaceSpecificationSecondaryPrivateIpAddressCount :: Maybe Int
    , _InstanceNetworkInterfaceSpecificationDescription :: Maybe Text
    , _InstanceNetworkInterfaceSpecificationDeviceIndex :: Maybe Int
    , _InstanceNetworkInterfaceSpecificationIpv6Addresses :: Maybe [InstanceIpv6Address]
    } deriving (Show, Eq)

data SpotFleet = SpotFleet
    { _SpotFleetSpotFleetRequestConfigData :: SpotFleetRequestConfigData
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''EbsBlockDevice)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''TargetGroup)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''ClassicLoadBalancer)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''InstanceIpv6Address)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 29 } ''SpotFleetLaunchSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 33 } ''FleetLaunchTemplateSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''LoadBalancersConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''GroupIdentifier)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''SpotPlacement)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''SpotFleetTagSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''SpotFleetMonitoring)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''LaunchTemplateOverrides)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''BlockDeviceMapping)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 27 } ''SpotFleetRequestConfigData)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 32 } ''IamInstanceProfileSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''TargetGroupsConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''LaunchTemplateConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 27 } ''ClassicLoadBalancersConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''PrivateIpAddressSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 38 } ''InstanceNetworkInterfaceSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''SpotFleet)

resourceJSON :: SpotFleet -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::SpotFleet" :: Text), "Properties" .= a ]
