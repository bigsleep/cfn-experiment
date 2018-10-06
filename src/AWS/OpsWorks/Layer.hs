{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.OpsWorks.Layer
    ( LifecycleEventConfiguration(..)
    , LoadBasedAutoScaling(..)
    , VolumeConfiguration(..)
    , ShutdownEventConfiguration(..)
    , Recipes(..)
    , AutoScalingThresholds(..)
    , Layer(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data LifecycleEventConfiguration = LifecycleEventConfiguration
    { _LifecycleEventConfigurationShutdownEventConfiguration :: Maybe ShutdownEventConfiguration
    } deriving (Show, Eq)

data LoadBasedAutoScaling = LoadBasedAutoScaling
    { _LoadBasedAutoScalingUpScaling :: Maybe AutoScalingThresholds
    , _LoadBasedAutoScalingEnable :: Maybe Bool
    , _LoadBasedAutoScalingDownScaling :: Maybe AutoScalingThresholds
    } deriving (Show, Eq)

data VolumeConfiguration = VolumeConfiguration
    { _VolumeConfigurationSize :: Maybe Int
    , _VolumeConfigurationIops :: Maybe Int
    , _VolumeConfigurationRaidLevel :: Maybe Int
    , _VolumeConfigurationNumberOfDisks :: Maybe Int
    , _VolumeConfigurationVolumeType :: Maybe Text
    , _VolumeConfigurationMountPoint :: Maybe Text
    } deriving (Show, Eq)

data ShutdownEventConfiguration = ShutdownEventConfiguration
    { _ShutdownEventConfigurationExecutionTimeout :: Maybe Int
    , _ShutdownEventConfigurationDelayUntilElbConnectionsDrained :: Maybe Bool
    } deriving (Show, Eq)

data Recipes = Recipes
    { _RecipesSetup :: Maybe [Text]
    , _RecipesShutdown :: Maybe [Text]
    , _RecipesUndeploy :: Maybe [Text]
    , _RecipesConfigure :: Maybe [Text]
    , _RecipesDeploy :: Maybe [Text]
    } deriving (Show, Eq)

data AutoScalingThresholds = AutoScalingThresholds
    { _AutoScalingThresholdsInstanceCount :: Maybe Int
    , _AutoScalingThresholdsIgnoreMetricsTime :: Maybe Int
    , _AutoScalingThresholdsLoadThreshold :: Maybe Double
    , _AutoScalingThresholdsThresholdsWaitTime :: Maybe Int
    , _AutoScalingThresholdsMemoryThreshold :: Maybe Double
    , _AutoScalingThresholdsCpuThreshold :: Maybe Double
    } deriving (Show, Eq)

data Layer = Layer
    { _LayerCustomInstanceProfileArn :: Maybe Text
    , _LayerCustomSecurityGroupIds :: Maybe [Text]
    , _LayerInstallUpdatesOnBoot :: Maybe Bool
    , _LayerLifecycleEventConfiguration :: Maybe LifecycleEventConfiguration
    , _LayerShortname :: Text
    , _LayerLoadBasedAutoScaling :: Maybe LoadBasedAutoScaling
    , _LayerCustomRecipes :: Maybe Recipes
    , _LayerCustomJson :: Maybe DA.Value
    , _LayerVolumeConfigurations :: Maybe [VolumeConfiguration]
    , _LayerEnableAutoHealing :: Bool
    , _LayerPackages :: Maybe [Text]
    , _LayerAttributes :: Maybe Map
    , _LayerName :: Text
    , _LayerAutoAssignPublicIps :: Bool
    , _LayerType :: Text
    , _LayerUseEbsOptimizedInstances :: Maybe Bool
    , _LayerStackId :: Text
    , _LayerTags :: Maybe [Tag]
    , _LayerAutoAssignElasticIps :: Bool
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 28 } ''LifecycleEventConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''LoadBasedAutoScaling)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''VolumeConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 27 } ''ShutdownEventConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Recipes)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''AutoScalingThresholds)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Layer)

resourceJSON :: Layer -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::OpsWorks::Layer" :: Text), "Properties" .= a ]
