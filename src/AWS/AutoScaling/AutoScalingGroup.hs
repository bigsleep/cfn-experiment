{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.AutoScaling.AutoScalingGroup
    ( TagProperty(..)
    , NotificationConfiguration(..)
    , LifecycleHookSpecification(..)
    , LaunchTemplateSpecification(..)
    , MetricsCollection(..)
    , AutoScalingGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data TagProperty = TagProperty
    { _TagPropertyValue :: Text
    , _TagPropertyKey :: Text
    , _TagPropertyPropagateAtLaunch :: Bool
    } deriving (Show, Eq)

data NotificationConfiguration = NotificationConfiguration
    { _NotificationConfigurationNotificationTypes :: Maybe [Text]
    , _NotificationConfigurationTopicARN :: Text
    } deriving (Show, Eq)

data LifecycleHookSpecification = LifecycleHookSpecification
    { _LifecycleHookSpecificationDefaultResult :: Maybe Text
    , _LifecycleHookSpecificationLifecycleHookName :: Text
    , _LifecycleHookSpecificationHeartbeatTimeout :: Maybe Int
    , _LifecycleHookSpecificationNotificationMetadata :: Maybe Text
    , _LifecycleHookSpecificationNotificationTargetARN :: Maybe Text
    , _LifecycleHookSpecificationLifecycleTransition :: Text
    , _LifecycleHookSpecificationRoleARN :: Maybe Text
    } deriving (Show, Eq)

data LaunchTemplateSpecification = LaunchTemplateSpecification
    { _LaunchTemplateSpecificationLaunchTemplateName :: Maybe Text
    , _LaunchTemplateSpecificationLaunchTemplateId :: Maybe Text
    , _LaunchTemplateSpecificationVersion :: Text
    } deriving (Show, Eq)

data MetricsCollection = MetricsCollection
    { _MetricsCollectionMetrics :: Maybe [Text]
    , _MetricsCollectionGranularity :: Text
    } deriving (Show, Eq)

data AutoScalingGroup = AutoScalingGroup
    { _AutoScalingGroupInstanceId :: Maybe Text
    , _AutoScalingGroupTerminationPolicies :: Maybe [Text]
    , _AutoScalingGroupHealthCheckGracePeriod :: Maybe Int
    , _AutoScalingGroupServiceLinkedRoleARN :: Maybe Text
    , _AutoScalingGroupVPCZoneIdentifier :: Maybe [Text]
    , _AutoScalingGroupTargetGroupARNs :: Maybe [Text]
    , _AutoScalingGroupMaxSize :: Text
    , _AutoScalingGroupAvailabilityZones :: Maybe [Text]
    , _AutoScalingGroupDesiredCapacity :: Maybe Text
    , _AutoScalingGroupMinSize :: Text
    , _AutoScalingGroupAutoScalingGroupName :: Maybe Text
    , _AutoScalingGroupLaunchConfigurationName :: Maybe Text
    , _AutoScalingGroupLifecycleHookSpecificationList :: Maybe [LifecycleHookSpecification]
    , _AutoScalingGroupHealthCheckType :: Maybe Text
    , _AutoScalingGroupLaunchTemplate :: Maybe LaunchTemplateSpecification
    , _AutoScalingGroupCooldown :: Maybe Text
    , _AutoScalingGroupPlacementGroup :: Maybe Text
    , _AutoScalingGroupNotificationConfigurations :: Maybe [NotificationConfiguration]
    , _AutoScalingGroupLoadBalancerNames :: Maybe [Text]
    , _AutoScalingGroupTags :: Maybe [TagProperty]
    , _AutoScalingGroupMetricsCollection :: Maybe [MetricsCollection]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''TagProperty)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''NotificationConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 27 } ''LifecycleHookSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 28 } ''LaunchTemplateSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''MetricsCollection)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''AutoScalingGroup)

resourceJSON :: AutoScalingGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::AutoScaling::AutoScalingGroup" :: Text), "Properties" .= a ]
