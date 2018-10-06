{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApplicationAutoScaling.ScalingPolicy
    ( TargetTrackingScalingPolicyConfiguration(..)
    , PredefinedMetricSpecification(..)
    , MetricDimension(..)
    , StepAdjustment(..)
    , CustomizedMetricSpecification(..)
    , StepScalingPolicyConfiguration(..)
    , ScalingPolicy(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data TargetTrackingScalingPolicyConfiguration = TargetTrackingScalingPolicyConfiguration
    { _TargetTrackingScalingPolicyConfigurationPredefinedMetricSpecification :: Maybe PredefinedMetricSpecification
    , _TargetTrackingScalingPolicyConfigurationTargetValue :: Double
    , _TargetTrackingScalingPolicyConfigurationScaleInCooldown :: Maybe Int
    , _TargetTrackingScalingPolicyConfigurationCustomizedMetricSpecification :: Maybe CustomizedMetricSpecification
    , _TargetTrackingScalingPolicyConfigurationDisableScaleIn :: Maybe Bool
    , _TargetTrackingScalingPolicyConfigurationScaleOutCooldown :: Maybe Int
    } deriving (Show, Eq)

data PredefinedMetricSpecification = PredefinedMetricSpecification
    { _PredefinedMetricSpecificationPredefinedMetricType :: Text
    , _PredefinedMetricSpecificationResourceLabel :: Maybe Text
    } deriving (Show, Eq)

data MetricDimension = MetricDimension
    { _MetricDimensionValue :: Text
    , _MetricDimensionName :: Text
    } deriving (Show, Eq)

data StepAdjustment = StepAdjustment
    { _StepAdjustmentMetricIntervalLowerBound :: Maybe Double
    , _StepAdjustmentMetricIntervalUpperBound :: Maybe Double
    , _StepAdjustmentScalingAdjustment :: Int
    } deriving (Show, Eq)

data CustomizedMetricSpecification = CustomizedMetricSpecification
    { _CustomizedMetricSpecificationMetricName :: Text
    , _CustomizedMetricSpecificationNamespace :: Text
    , _CustomizedMetricSpecificationDimensions :: Maybe [MetricDimension]
    , _CustomizedMetricSpecificationUnit :: Maybe Text
    , _CustomizedMetricSpecificationStatistic :: Text
    } deriving (Show, Eq)

data StepScalingPolicyConfiguration = StepScalingPolicyConfiguration
    { _StepScalingPolicyConfigurationStepAdjustments :: Maybe [StepAdjustment]
    , _StepScalingPolicyConfigurationAdjustmentType :: Maybe Text
    , _StepScalingPolicyConfigurationCooldown :: Maybe Int
    , _StepScalingPolicyConfigurationMetricAggregationType :: Maybe Text
    , _StepScalingPolicyConfigurationMinAdjustmentMagnitude :: Maybe Int
    } deriving (Show, Eq)

data ScalingPolicy = ScalingPolicy
    { _ScalingPolicyScalableDimension :: Maybe Text
    , _ScalingPolicyResourceId :: Maybe Text
    , _ScalingPolicyPolicyName :: Text
    , _ScalingPolicyPolicyType :: Text
    , _ScalingPolicyTargetTrackingScalingPolicyConfiguration :: Maybe TargetTrackingScalingPolicyConfiguration
    , _ScalingPolicyServiceNamespace :: Maybe Text
    , _ScalingPolicyStepScalingPolicyConfiguration :: Maybe StepScalingPolicyConfiguration
    , _ScalingPolicyScalingTargetId :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 41 } ''TargetTrackingScalingPolicyConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''PredefinedMetricSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''MetricDimension)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''StepAdjustment)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''CustomizedMetricSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 31 } ''StepScalingPolicyConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''ScalingPolicy)

resourceJSON :: ScalingPolicy -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApplicationAutoScaling::ScalingPolicy" :: Text), "Properties" .= a ]
