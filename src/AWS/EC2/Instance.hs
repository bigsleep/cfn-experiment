{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.Instance
    ( ElasticGpuSpecification(..)
    , SsmAssociation(..)
    , Ebs(..)
    , Volume(..)
    , NoDevice(..)
    , NetworkInterface(..)
    , InstanceIpv6Address(..)
    , BlockDeviceMapping(..)
    , CreditSpecification(..)
    , AssociationParameter(..)
    , LaunchTemplateSpecification(..)
    , PrivateIpAddressSpecification(..)
    , Instance(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ElasticGpuSpecification = ElasticGpuSpecification
    { _ElasticGpuSpecificationType :: Text
    } deriving (Show, Eq)

data SsmAssociation = SsmAssociation
    { _SsmAssociationDocumentName :: Text
    , _SsmAssociationAssociationParameters :: Maybe [AssociationParameter]
    } deriving (Show, Eq)

data Ebs = Ebs
    { _EbsDeleteOnTermination :: Maybe Bool
    , _EbsVolumeSize :: Maybe Int
    , _EbsIops :: Maybe Int
    , _EbsEncrypted :: Maybe Bool
    , _EbsVolumeType :: Maybe Text
    , _EbsSnapshotId :: Maybe Text
    } deriving (Show, Eq)

data Volume = Volume
    { _VolumeDevice :: Text
    , _VolumeVolumeId :: Text
    } deriving (Show, Eq)

data NoDevice = NoDevice
    {} deriving (Show, Eq)

data NetworkInterface = NetworkInterface
    { _NetworkInterfacePrivateIpAddresses :: Maybe [PrivateIpAddressSpecification]
    , _NetworkInterfaceDeleteOnTermination :: Maybe Bool
    , _NetworkInterfaceAssociatePublicIpAddress :: Maybe Bool
    , _NetworkInterfaceNetworkInterfaceId :: Maybe Text
    , _NetworkInterfaceSubnetId :: Maybe Text
    , _NetworkInterfaceIpv6AddressCount :: Maybe Int
    , _NetworkInterfacePrivateIpAddress :: Maybe Text
    , _NetworkInterfaceGroupSet :: Maybe [Text]
    , _NetworkInterfaceSecondaryPrivateIpAddressCount :: Maybe Int
    , _NetworkInterfaceDescription :: Maybe Text
    , _NetworkInterfaceDeviceIndex :: Text
    , _NetworkInterfaceIpv6Addresses :: Maybe [InstanceIpv6Address]
    } deriving (Show, Eq)

data InstanceIpv6Address = InstanceIpv6Address
    { _InstanceIpv6AddressIpv6Address :: Text
    } deriving (Show, Eq)

data BlockDeviceMapping = BlockDeviceMapping
    { _BlockDeviceMappingVirtualName :: Maybe Text
    , _BlockDeviceMappingNoDevice :: Maybe NoDevice
    , _BlockDeviceMappingEbs :: Maybe Ebs
    , _BlockDeviceMappingDeviceName :: Text
    } deriving (Show, Eq)

data CreditSpecification = CreditSpecification
    { _CreditSpecificationCPUCredits :: Maybe Text
    } deriving (Show, Eq)

data AssociationParameter = AssociationParameter
    { _AssociationParameterValue :: [Text]
    , _AssociationParameterKey :: Text
    } deriving (Show, Eq)

data LaunchTemplateSpecification = LaunchTemplateSpecification
    { _LaunchTemplateSpecificationLaunchTemplateName :: Maybe Text
    , _LaunchTemplateSpecificationLaunchTemplateId :: Maybe Text
    , _LaunchTemplateSpecificationVersion :: Text
    } deriving (Show, Eq)

data PrivateIpAddressSpecification = PrivateIpAddressSpecification
    { _PrivateIpAddressSpecificationPrimary :: Bool
    , _PrivateIpAddressSpecificationPrivateIpAddress :: Text
    } deriving (Show, Eq)

data Instance = Instance
    { _InstanceSsmAssociations :: Maybe [SsmAssociation]
    , _InstanceAdditionalInfo :: Maybe Text
    , _InstanceSecurityGroupIds :: Maybe [Text]
    , _InstanceSecurityGroups :: Maybe [Text]
    , _InstanceAffinity :: Maybe Text
    , _InstanceHostId :: Maybe Text
    , _InstanceSourceDestCheck :: Maybe Bool
    , _InstanceDisableApiTermination :: Maybe Bool
    , _InstanceKeyName :: Maybe Text
    , _InstanceNetworkInterfaces :: Maybe [NetworkInterface]
    , _InstanceRamdiskId :: Maybe Text
    , _InstanceSubnetId :: Maybe Text
    , _InstanceKernelId :: Maybe Text
    , _InstanceElasticGpuSpecifications :: Maybe [ElasticGpuSpecification]
    , _InstanceInstanceType :: Maybe Text
    , _InstanceEbsOptimized :: Maybe Bool
    , _InstanceUserData :: Maybe Text
    , _InstanceMonitoring :: Maybe Bool
    , _InstanceIpv6AddressCount :: Maybe Int
    , _InstanceAvailabilityZone :: Maybe Text
    , _InstanceIamInstanceProfile :: Maybe Text
    , _InstanceImageId :: Maybe Text
    , _InstanceTenancy :: Maybe Text
    , _InstancePrivateIpAddress :: Maybe Text
    , _InstanceInstanceInitiatedShutdownBehavior :: Maybe Text
    , _InstanceLaunchTemplate :: Maybe LaunchTemplateSpecification
    , _InstanceCreditSpecification :: Maybe CreditSpecification
    , _InstanceVolumes :: Maybe [Volume]
    , _InstanceBlockDeviceMappings :: Maybe [BlockDeviceMapping]
    , _InstanceTags :: Maybe [Tag]
    , _InstancePlacementGroupName :: Maybe Text
    , _InstanceIpv6Addresses :: Maybe [InstanceIpv6Address]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''ElasticGpuSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''SsmAssociation)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 4 } ''Ebs)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Volume)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''NoDevice)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''NetworkInterface)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''InstanceIpv6Address)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''BlockDeviceMapping)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''CreditSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''AssociationParameter)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 28 } ''LaunchTemplateSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''PrivateIpAddressSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Instance)

resourceJSON :: Instance -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::Instance" :: Text), "Properties" .= a ]
