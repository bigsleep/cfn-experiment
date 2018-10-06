{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EMR.InstanceGroupConfig
    ( EbsBlockDeviceConfig(..)
    , ScalingTrigger(..)
    , CloudWatchAlarmDefinition(..)
    , AutoScalingPolicy(..)
    , Configuration(..)
    , VolumeSpecification(..)
    , ScalingConstraints(..)
    , SimpleScalingPolicyConfiguration(..)
    , ScalingRule(..)
    , ScalingAction(..)
    , MetricDimension(..)
    , EbsConfiguration(..)
    , InstanceGroupConfig(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data EbsBlockDeviceConfig = EbsBlockDeviceConfig
    { _EbsBlockDeviceConfigVolumesPerInstance :: Maybe Int
    , _EbsBlockDeviceConfigVolumeSpecification :: VolumeSpecification
    } deriving (Show, Eq)

data ScalingTrigger = ScalingTrigger
    { _ScalingTriggerCloudWatchAlarmDefinition :: CloudWatchAlarmDefinition
    } deriving (Show, Eq)

data CloudWatchAlarmDefinition = CloudWatchAlarmDefinition
    { _CloudWatchAlarmDefinitionPeriod :: Int
    , _CloudWatchAlarmDefinitionEvaluationPeriods :: Maybe Int
    , _CloudWatchAlarmDefinitionMetricName :: Text
    , _CloudWatchAlarmDefinitionNamespace :: Maybe Text
    , _CloudWatchAlarmDefinitionComparisonOperator :: Text
    , _CloudWatchAlarmDefinitionThreshold :: Double
    , _CloudWatchAlarmDefinitionDimensions :: Maybe [MetricDimension]
    , _CloudWatchAlarmDefinitionUnit :: Maybe Text
    , _CloudWatchAlarmDefinitionStatistic :: Maybe Text
    } deriving (Show, Eq)

data AutoScalingPolicy = AutoScalingPolicy
    { _AutoScalingPolicyRules :: [ScalingRule]
    , _AutoScalingPolicyConstraints :: ScalingConstraints
    } deriving (Show, Eq)

data Configuration = Configuration
    { _ConfigurationConfigurations :: Maybe [Configuration]
    , _ConfigurationClassification :: Maybe Text
    , _ConfigurationConfigurationProperties :: Maybe Map
    } deriving (Show, Eq)

data VolumeSpecification = VolumeSpecification
    { _VolumeSpecificationIops :: Maybe Int
    , _VolumeSpecificationSizeInGB :: Int
    , _VolumeSpecificationVolumeType :: Text
    } deriving (Show, Eq)

data ScalingConstraints = ScalingConstraints
    { _ScalingConstraintsMaxCapacity :: Int
    , _ScalingConstraintsMinCapacity :: Int
    } deriving (Show, Eq)

data SimpleScalingPolicyConfiguration = SimpleScalingPolicyConfiguration
    { _SimpleScalingPolicyConfigurationAdjustmentType :: Maybe Text
    , _SimpleScalingPolicyConfigurationScalingAdjustment :: Int
    , _SimpleScalingPolicyConfigurationCoolDown :: Maybe Int
    } deriving (Show, Eq)

data ScalingRule = ScalingRule
    { _ScalingRuleAction :: ScalingAction
    , _ScalingRuleName :: Text
    , _ScalingRuleTrigger :: ScalingTrigger
    , _ScalingRuleDescription :: Maybe Text
    } deriving (Show, Eq)

data ScalingAction = ScalingAction
    { _ScalingActionMarket :: Maybe Text
    , _ScalingActionSimpleScalingPolicyConfiguration :: SimpleScalingPolicyConfiguration
    } deriving (Show, Eq)

data MetricDimension = MetricDimension
    { _MetricDimensionValue :: Text
    , _MetricDimensionKey :: Text
    } deriving (Show, Eq)

data EbsConfiguration = EbsConfiguration
    { _EbsConfigurationEbsOptimized :: Maybe Bool
    , _EbsConfigurationEbsBlockDeviceConfigs :: Maybe [EbsBlockDeviceConfig]
    } deriving (Show, Eq)

data InstanceGroupConfig = InstanceGroupConfig
    { _InstanceGroupConfigEbsConfiguration :: Maybe EbsConfiguration
    , _InstanceGroupConfigBidPrice :: Maybe Text
    , _InstanceGroupConfigInstanceCount :: Int
    , _InstanceGroupConfigInstanceRole :: Text
    , _InstanceGroupConfigJobFlowId :: Text
    , _InstanceGroupConfigConfigurations :: Maybe [Configuration]
    , _InstanceGroupConfigInstanceType :: Text
    , _InstanceGroupConfigMarket :: Maybe Text
    , _InstanceGroupConfigName :: Maybe Text
    , _InstanceGroupConfigAutoScalingPolicy :: Maybe AutoScalingPolicy
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''EbsBlockDeviceConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''ScalingTrigger)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''CloudWatchAlarmDefinition)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''AutoScalingPolicy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''Configuration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''VolumeSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''ScalingConstraints)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 33 } ''SimpleScalingPolicyConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''ScalingRule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''ScalingAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''MetricDimension)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''EbsConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''InstanceGroupConfig)

resourceJSON :: InstanceGroupConfig -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EMR::InstanceGroupConfig" :: Text), "Properties" .= a ]
