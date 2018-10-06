{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EMR.Cluster
    ( EbsBlockDeviceConfig(..)
    , InstanceGroupConfig(..)
    , PlacementType(..)
    , CloudWatchAlarmDefinition(..)
    , BootstrapActionConfig(..)
    , ScalingRule(..)
    , ScalingConstraints(..)
    , SimpleScalingPolicyConfiguration(..)
    , ScalingAction(..)
    , VolumeSpecification(..)
    , KerberosAttributes(..)
    , Application(..)
    , EbsConfiguration(..)
    , MetricDimension(..)
    , SpotProvisioningSpecification(..)
    , ScriptBootstrapActionConfig(..)
    , InstanceTypeConfig(..)
    , InstanceFleetProvisioningSpecifications(..)
    , Configuration(..)
    , JobFlowInstancesConfig(..)
    , ScalingTrigger(..)
    , InstanceFleetConfig(..)
    , AutoScalingPolicy(..)
    , Cluster(..)
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

data InstanceGroupConfig = InstanceGroupConfig
    { _InstanceGroupConfigEbsConfiguration :: Maybe EbsConfiguration
    , _InstanceGroupConfigBidPrice :: Maybe Text
    , _InstanceGroupConfigInstanceCount :: Int
    , _InstanceGroupConfigConfigurations :: Maybe [Configuration]
    , _InstanceGroupConfigInstanceType :: Text
    , _InstanceGroupConfigMarket :: Maybe Text
    , _InstanceGroupConfigName :: Maybe Text
    , _InstanceGroupConfigAutoScalingPolicy :: Maybe AutoScalingPolicy
    } deriving (Show, Eq)

data PlacementType = PlacementType
    { _PlacementTypeAvailabilityZone :: Text
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

data BootstrapActionConfig = BootstrapActionConfig
    { _BootstrapActionConfigName :: Text
    , _BootstrapActionConfigScriptBootstrapAction :: ScriptBootstrapActionConfig
    } deriving (Show, Eq)

data ScalingRule = ScalingRule
    { _ScalingRuleAction :: ScalingAction
    , _ScalingRuleName :: Text
    , _ScalingRuleTrigger :: ScalingTrigger
    , _ScalingRuleDescription :: Maybe Text
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

data ScalingAction = ScalingAction
    { _ScalingActionMarket :: Maybe Text
    , _ScalingActionSimpleScalingPolicyConfiguration :: SimpleScalingPolicyConfiguration
    } deriving (Show, Eq)

data VolumeSpecification = VolumeSpecification
    { _VolumeSpecificationIops :: Maybe Int
    , _VolumeSpecificationSizeInGB :: Int
    , _VolumeSpecificationVolumeType :: Text
    } deriving (Show, Eq)

data KerberosAttributes = KerberosAttributes
    { _KerberosAttributesKdcAdminPassword :: Text
    , _KerberosAttributesRealm :: Text
    , _KerberosAttributesADDomainJoinPassword :: Maybe Text
    , _KerberosAttributesCrossRealmTrustPrincipalPassword :: Maybe Text
    , _KerberosAttributesADDomainJoinUser :: Maybe Text
    } deriving (Show, Eq)

data Application = Application
    { _ApplicationArgs :: Maybe [Text]
    , _ApplicationAdditionalInfo :: Maybe Map
    , _ApplicationName :: Maybe Text
    , _ApplicationVersion :: Maybe Text
    } deriving (Show, Eq)

data EbsConfiguration = EbsConfiguration
    { _EbsConfigurationEbsOptimized :: Maybe Bool
    , _EbsConfigurationEbsBlockDeviceConfigs :: Maybe [EbsBlockDeviceConfig]
    } deriving (Show, Eq)

data MetricDimension = MetricDimension
    { _MetricDimensionValue :: Text
    , _MetricDimensionKey :: Text
    } deriving (Show, Eq)

data SpotProvisioningSpecification = SpotProvisioningSpecification
    { _SpotProvisioningSpecificationBlockDurationMinutes :: Maybe Int
    , _SpotProvisioningSpecificationTimeoutAction :: Text
    , _SpotProvisioningSpecificationTimeoutDurationMinutes :: Int
    } deriving (Show, Eq)

data ScriptBootstrapActionConfig = ScriptBootstrapActionConfig
    { _ScriptBootstrapActionConfigArgs :: Maybe [Text]
    , _ScriptBootstrapActionConfigPath :: Text
    } deriving (Show, Eq)

data InstanceTypeConfig = InstanceTypeConfig
    { _InstanceTypeConfigEbsConfiguration :: Maybe EbsConfiguration
    , _InstanceTypeConfigBidPrice :: Maybe Text
    , _InstanceTypeConfigWeightedCapacity :: Maybe Int
    , _InstanceTypeConfigConfigurations :: Maybe [Configuration]
    , _InstanceTypeConfigInstanceType :: Text
    , _InstanceTypeConfigBidPriceAsPercentageOfOnDemandPrice :: Maybe Double
    } deriving (Show, Eq)

data InstanceFleetProvisioningSpecifications = InstanceFleetProvisioningSpecifications
    { _InstanceFleetProvisioningSpecificationsSpotSpecification :: SpotProvisioningSpecification
    } deriving (Show, Eq)

data Configuration = Configuration
    { _ConfigurationConfigurations :: Maybe [Configuration]
    , _ConfigurationClassification :: Maybe Text
    , _ConfigurationConfigurationProperties :: Maybe Map
    } deriving (Show, Eq)

data JobFlowInstancesConfig = JobFlowInstancesConfig
    { _JobFlowInstancesConfigEc2KeyName :: Maybe Text
    , _JobFlowInstancesConfigCoreInstanceFleet :: Maybe InstanceFleetConfig
    , _JobFlowInstancesConfigCoreInstanceGroup :: Maybe InstanceGroupConfig
    , _JobFlowInstancesConfigEmrManagedSlaveSecurityGroup :: Maybe Text
    , _JobFlowInstancesConfigAdditionalSlaveSecurityGroups :: Maybe [Text]
    , _JobFlowInstancesConfigHadoopVersion :: Maybe Text
    , _JobFlowInstancesConfigAdditionalMasterSecurityGroups :: Maybe [Text]
    , _JobFlowInstancesConfigEmrManagedMasterSecurityGroup :: Maybe Text
    , _JobFlowInstancesConfigMasterInstanceGroup :: Maybe InstanceGroupConfig
    , _JobFlowInstancesConfigEc2SubnetId :: Maybe Text
    , _JobFlowInstancesConfigServiceAccessSecurityGroup :: Maybe Text
    , _JobFlowInstancesConfigMasterInstanceFleet :: Maybe InstanceFleetConfig
    , _JobFlowInstancesConfigTerminationProtected :: Maybe Bool
    , _JobFlowInstancesConfigPlacement :: Maybe PlacementType
    } deriving (Show, Eq)

data ScalingTrigger = ScalingTrigger
    { _ScalingTriggerCloudWatchAlarmDefinition :: CloudWatchAlarmDefinition
    } deriving (Show, Eq)

data InstanceFleetConfig = InstanceFleetConfig
    { _InstanceFleetConfigInstanceTypeConfigs :: Maybe [InstanceTypeConfig]
    , _InstanceFleetConfigTargetOnDemandCapacity :: Maybe Int
    , _InstanceFleetConfigName :: Maybe Text
    , _InstanceFleetConfigTargetSpotCapacity :: Maybe Int
    , _InstanceFleetConfigLaunchSpecifications :: Maybe InstanceFleetProvisioningSpecifications
    } deriving (Show, Eq)

data AutoScalingPolicy = AutoScalingPolicy
    { _AutoScalingPolicyRules :: [ScalingRule]
    , _AutoScalingPolicyConstraints :: ScalingConstraints
    } deriving (Show, Eq)

data Cluster = Cluster
    { _ClusterEbsRootVolumeSize :: Maybe Int
    , _ClusterAdditionalInfo :: Maybe DA.Value
    , _ClusterConfigurations :: Maybe [Configuration]
    , _ClusterCustomAmiId :: Maybe Text
    , _ClusterAutoScalingRole :: Maybe Text
    , _ClusterSecurityConfiguration :: Maybe Text
    , _ClusterScaleDownBehavior :: Maybe Text
    , _ClusterJobFlowRole :: Text
    , _ClusterBootstrapActions :: Maybe [BootstrapActionConfig]
    , _ClusterReleaseLabel :: Maybe Text
    , _ClusterName :: Text
    , _ClusterLogUri :: Maybe Text
    , _ClusterKerberosAttributes :: Maybe KerberosAttributes
    , _ClusterInstances :: JobFlowInstancesConfig
    , _ClusterVisibleToAllUsers :: Maybe Bool
    , _ClusterApplications :: Maybe [Application]
    , _ClusterTags :: Maybe [Tag]
    , _ClusterServiceRole :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''EbsBlockDeviceConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''InstanceGroupConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''PlacementType)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''CloudWatchAlarmDefinition)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''BootstrapActionConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''ScalingRule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''ScalingConstraints)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 33 } ''SimpleScalingPolicyConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''ScalingAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''VolumeSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''KerberosAttributes)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Application)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''EbsConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''MetricDimension)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''SpotProvisioningSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 28 } ''ScriptBootstrapActionConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''InstanceTypeConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 40 } ''InstanceFleetProvisioningSpecifications)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''Configuration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 23 } ''JobFlowInstancesConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''ScalingTrigger)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''InstanceFleetConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''AutoScalingPolicy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Cluster)

resourceJSON :: Cluster -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EMR::Cluster" :: Text), "Properties" .= a ]
