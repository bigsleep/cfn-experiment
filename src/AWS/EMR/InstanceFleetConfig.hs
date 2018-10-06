{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EMR.InstanceFleetConfig
    ( InstanceTypeConfig(..)
    , EbsConfiguration(..)
    , InstanceFleetProvisioningSpecifications(..)
    , Configuration(..)
    , SpotProvisioningSpecification(..)
    , EbsBlockDeviceConfig(..)
    , VolumeSpecification(..)
    , InstanceFleetConfig(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data InstanceTypeConfig = InstanceTypeConfig
    { _InstanceTypeConfigEbsConfiguration :: Maybe EbsConfiguration
    , _InstanceTypeConfigBidPrice :: Maybe Text
    , _InstanceTypeConfigWeightedCapacity :: Maybe Int
    , _InstanceTypeConfigConfigurations :: Maybe [Configuration]
    , _InstanceTypeConfigInstanceType :: Text
    , _InstanceTypeConfigBidPriceAsPercentageOfOnDemandPrice :: Maybe Double
    } deriving (Show, Eq)

data EbsConfiguration = EbsConfiguration
    { _EbsConfigurationEbsOptimized :: Maybe Bool
    , _EbsConfigurationEbsBlockDeviceConfigs :: Maybe [EbsBlockDeviceConfig]
    } deriving (Show, Eq)

data InstanceFleetProvisioningSpecifications = InstanceFleetProvisioningSpecifications
    { _InstanceFleetProvisioningSpecificationsSpotSpecification :: SpotProvisioningSpecification
    } deriving (Show, Eq)

data Configuration = Configuration
    { _ConfigurationConfigurations :: Maybe [Configuration]
    , _ConfigurationClassification :: Maybe Text
    , _ConfigurationConfigurationProperties :: Maybe Map
    } deriving (Show, Eq)

data SpotProvisioningSpecification = SpotProvisioningSpecification
    { _SpotProvisioningSpecificationBlockDurationMinutes :: Maybe Int
    , _SpotProvisioningSpecificationTimeoutAction :: Text
    , _SpotProvisioningSpecificationTimeoutDurationMinutes :: Int
    } deriving (Show, Eq)

data EbsBlockDeviceConfig = EbsBlockDeviceConfig
    { _EbsBlockDeviceConfigVolumesPerInstance :: Maybe Int
    , _EbsBlockDeviceConfigVolumeSpecification :: VolumeSpecification
    } deriving (Show, Eq)

data VolumeSpecification = VolumeSpecification
    { _VolumeSpecificationIops :: Maybe Int
    , _VolumeSpecificationSizeInGB :: Int
    , _VolumeSpecificationVolumeType :: Text
    } deriving (Show, Eq)

data InstanceFleetConfig = InstanceFleetConfig
    { _InstanceFleetConfigInstanceTypeConfigs :: Maybe [InstanceTypeConfig]
    , _InstanceFleetConfigTargetOnDemandCapacity :: Maybe Int
    , _InstanceFleetConfigInstanceFleetType :: Text
    , _InstanceFleetConfigName :: Maybe Text
    , _InstanceFleetConfigClusterId :: Text
    , _InstanceFleetConfigTargetSpotCapacity :: Maybe Int
    , _InstanceFleetConfigLaunchSpecifications :: Maybe InstanceFleetProvisioningSpecifications
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''InstanceTypeConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''EbsConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 40 } ''InstanceFleetProvisioningSpecifications)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''Configuration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''SpotProvisioningSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''EbsBlockDeviceConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''VolumeSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''InstanceFleetConfig)

resourceJSON :: InstanceFleetConfig -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EMR::InstanceFleetConfig" :: Text), "Properties" .= a ]
