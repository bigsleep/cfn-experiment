{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.AutoScaling.ScalingPolicy
    ( TargetTrackingConfiguration(..)
    , MetricDimension(..)
    , StepAdjustment(..)
    , CustomizedMetricSpecification(..)
    , PredefinedMetricSpecification(..)
    , ScalingPolicy(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data TargetTrackingConfiguration = TargetTrackingConfiguration
    { _TargetTrackingConfigurationPredefinedMetricSpecification :: Maybe PredefinedMetricSpecification
    , _TargetTrackingConfigurationTargetValue :: Double
    , _TargetTrackingConfigurationCustomizedMetricSpecification :: Maybe CustomizedMetricSpecification
    , _TargetTrackingConfigurationDisableScaleIn :: Maybe Bool
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

data PredefinedMetricSpecification = PredefinedMetricSpecification
    { _PredefinedMetricSpecificationPredefinedMetricType :: Text
    , _PredefinedMetricSpecificationResourceLabel :: Maybe Text
    } deriving (Show, Eq)

data ScalingPolicy = ScalingPolicy
    { _ScalingPolicyEstimatedInstanceWarmup :: Maybe Int
    , _ScalingPolicyPolicyType :: Maybe Text
    , _ScalingPolicyStepAdjustments :: Maybe [StepAdjustment]
    , _ScalingPolicyTargetTrackingConfiguration :: Maybe TargetTrackingConfiguration
    , _ScalingPolicyAdjustmentType :: Maybe Text
    , _ScalingPolicyAutoScalingGroupName :: Text
    , _ScalingPolicyScalingAdjustment :: Maybe Int
    , _ScalingPolicyCooldown :: Maybe Text
    , _ScalingPolicyMetricAggregationType :: Maybe Text
    , _ScalingPolicyMinAdjustmentMagnitude :: Maybe Int
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 28 } ''TargetTrackingConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''MetricDimension)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''StepAdjustment)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''CustomizedMetricSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''PredefinedMetricSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''ScalingPolicy)

resourceJSON :: ScalingPolicy -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::AutoScaling::ScalingPolicy" :: Text), "Properties" .= a ]
