{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.LaunchTemplate
    ( LaunchTemplateData(..)
    , Ipv6Add(..)
    , CreditSpecification(..)
    , IamInstanceProfile(..)
    , TagSpecification(..)
    , ElasticGpuSpecification(..)
    , Placement(..)
    , PrivateIpAdd(..)
    , BlockDeviceMapping(..)
    , InstanceMarketOptions(..)
    , SpotOptions(..)
    , Monitoring(..)
    , Ebs(..)
    , NetworkInterface(..)
    , LaunchTemplate(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data LaunchTemplateData = LaunchTemplateData
    { _LaunchTemplateDataSecurityGroupIds :: Maybe [Text]
    , _LaunchTemplateDataSecurityGroups :: Maybe [Text]
    , _LaunchTemplateDataInstanceMarketOptions :: Maybe InstanceMarketOptions
    , _LaunchTemplateDataDisableApiTermination :: Maybe Bool
    , _LaunchTemplateDataKeyName :: Maybe Text
    , _LaunchTemplateDataNetworkInterfaces :: Maybe [NetworkInterface]
    , _LaunchTemplateDataRamDiskId :: Maybe Text
    , _LaunchTemplateDataKernelId :: Maybe Text
    , _LaunchTemplateDataElasticGpuSpecifications :: Maybe [ElasticGpuSpecification]
    , _LaunchTemplateDataInstanceType :: Maybe Text
    , _LaunchTemplateDataEbsOptimized :: Maybe Bool
    , _LaunchTemplateDataUserData :: Maybe Text
    , _LaunchTemplateDataMonitoring :: Maybe Monitoring
    , _LaunchTemplateDataTagSpecifications :: Maybe [TagSpecification]
    , _LaunchTemplateDataIamInstanceProfile :: Maybe IamInstanceProfile
    , _LaunchTemplateDataImageId :: Maybe Text
    , _LaunchTemplateDataInstanceInitiatedShutdownBehavior :: Maybe Text
    , _LaunchTemplateDataCreditSpecification :: Maybe CreditSpecification
    , _LaunchTemplateDataBlockDeviceMappings :: Maybe [BlockDeviceMapping]
    , _LaunchTemplateDataPlacement :: Maybe Placement
    } deriving (Show, Eq)

data Ipv6Add = Ipv6Add
    { _Ipv6AddIpv6Address :: Maybe Text
    } deriving (Show, Eq)

data CreditSpecification = CreditSpecification
    { _CreditSpecificationCpuCredits :: Maybe Text
    } deriving (Show, Eq)

data IamInstanceProfile = IamInstanceProfile
    { _IamInstanceProfileArn :: Maybe Text
    , _IamInstanceProfileName :: Maybe Text
    } deriving (Show, Eq)

data TagSpecification = TagSpecification
    { _TagSpecificationResourceType :: Maybe Text
    , _TagSpecificationTags :: Maybe [Tag]
    } deriving (Show, Eq)

data ElasticGpuSpecification = ElasticGpuSpecification
    { _ElasticGpuSpecificationType :: Maybe Text
    } deriving (Show, Eq)

data Placement = Placement
    { _PlacementAffinity :: Maybe Text
    , _PlacementHostId :: Maybe Text
    , _PlacementAvailabilityZone :: Maybe Text
    , _PlacementTenancy :: Maybe Text
    , _PlacementGroupName :: Maybe Text
    } deriving (Show, Eq)

data PrivateIpAdd = PrivateIpAdd
    { _PrivateIpAddPrimary :: Maybe Bool
    , _PrivateIpAddPrivateIpAddress :: Maybe Text
    } deriving (Show, Eq)

data BlockDeviceMapping = BlockDeviceMapping
    { _BlockDeviceMappingVirtualName :: Maybe Text
    , _BlockDeviceMappingNoDevice :: Maybe Text
    , _BlockDeviceMappingEbs :: Maybe Ebs
    , _BlockDeviceMappingDeviceName :: Maybe Text
    } deriving (Show, Eq)

data InstanceMarketOptions = InstanceMarketOptions
    { _InstanceMarketOptionsMarketType :: Maybe Text
    , _InstanceMarketOptionsSpotOptions :: Maybe SpotOptions
    } deriving (Show, Eq)

data SpotOptions = SpotOptions
    { _SpotOptionsInstanceInterruptionBehavior :: Maybe Text
    , _SpotOptionsSpotInstanceType :: Maybe Text
    , _SpotOptionsMaxPrice :: Maybe Text
    } deriving (Show, Eq)

data Monitoring = Monitoring
    { _MonitoringEnabled :: Maybe Bool
    } deriving (Show, Eq)

data Ebs = Ebs
    { _EbsDeleteOnTermination :: Maybe Bool
    , _EbsVolumeSize :: Maybe Int
    , _EbsIops :: Maybe Int
    , _EbsEncrypted :: Maybe Bool
    , _EbsKmsKeyId :: Maybe Text
    , _EbsVolumeType :: Maybe Text
    , _EbsSnapshotId :: Maybe Text
    } deriving (Show, Eq)

data NetworkInterface = NetworkInterface
    { _NetworkInterfaceGroups :: Maybe [Text]
    , _NetworkInterfacePrivateIpAddresses :: Maybe [PrivateIpAdd]
    , _NetworkInterfaceDeleteOnTermination :: Maybe Bool
    , _NetworkInterfaceAssociatePublicIpAddress :: Maybe Bool
    , _NetworkInterfaceNetworkInterfaceId :: Maybe Text
    , _NetworkInterfaceSubnetId :: Maybe Text
    , _NetworkInterfaceIpv6AddressCount :: Maybe Int
    , _NetworkInterfacePrivateIpAddress :: Maybe Text
    , _NetworkInterfaceSecondaryPrivateIpAddressCount :: Maybe Int
    , _NetworkInterfaceDescription :: Maybe Text
    , _NetworkInterfaceDeviceIndex :: Maybe Int
    , _NetworkInterfaceIpv6Addresses :: Maybe [Ipv6Add]
    } deriving (Show, Eq)

data LaunchTemplate = LaunchTemplate
    { _LaunchTemplateLaunchTemplateName :: Maybe Text
    , _LaunchTemplateLaunchTemplateData :: Maybe LaunchTemplateData
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''LaunchTemplateData)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Ipv6Add)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''CreditSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''IamInstanceProfile)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''TagSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''ElasticGpuSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Placement)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''PrivateIpAdd)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''BlockDeviceMapping)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''InstanceMarketOptions)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''SpotOptions)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''Monitoring)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 4 } ''Ebs)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''NetworkInterface)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''LaunchTemplate)

resourceJSON :: LaunchTemplate -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::LaunchTemplate" :: Text), "Properties" .= a ]
