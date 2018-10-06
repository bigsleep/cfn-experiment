{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ECS.Service
    ( PlacementConstraint(..)
    , LoadBalancer(..)
    , DeploymentConfiguration(..)
    , NetworkConfiguration(..)
    , ServiceRegistry(..)
    , AwsVpcConfiguration(..)
    , PlacementStrategy(..)
    , Service(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data PlacementConstraint = PlacementConstraint
    { _PlacementConstraintExpression :: Maybe Text
    , _PlacementConstraintType :: Text
    } deriving (Show, Eq)

data LoadBalancer = LoadBalancer
    { _LoadBalancerLoadBalancerName :: Maybe Text
    , _LoadBalancerContainerName :: Maybe Text
    , _LoadBalancerTargetGroupArn :: Maybe Text
    , _LoadBalancerContainerPort :: Int
    } deriving (Show, Eq)

data DeploymentConfiguration = DeploymentConfiguration
    { _DeploymentConfigurationMinimumHealthyPercent :: Maybe Int
    , _DeploymentConfigurationMaximumPercent :: Maybe Int
    } deriving (Show, Eq)

data NetworkConfiguration = NetworkConfiguration
    { _NetworkConfigurationAwsvpcConfiguration :: Maybe AwsVpcConfiguration
    } deriving (Show, Eq)

data ServiceRegistry = ServiceRegistry
    { _ServiceRegistryContainerName :: Maybe Text
    , _ServiceRegistryRegistryArn :: Maybe Text
    , _ServiceRegistryContainerPort :: Maybe Int
    , _ServiceRegistryPort :: Maybe Int
    } deriving (Show, Eq)

data AwsVpcConfiguration = AwsVpcConfiguration
    { _AwsVpcConfigurationSecurityGroups :: Maybe [Text]
    , _AwsVpcConfigurationSubnets :: [Text]
    , _AwsVpcConfigurationAssignPublicIp :: Maybe Text
    } deriving (Show, Eq)

data PlacementStrategy = PlacementStrategy
    { _PlacementStrategyField :: Maybe Text
    , _PlacementStrategyType :: Text
    } deriving (Show, Eq)

data Service = Service
    { _ServicePlacementStrategies :: Maybe [PlacementStrategy]
    , _ServiceCluster :: Maybe Text
    , _ServicePlatformVersion :: Maybe Text
    , _ServiceDesiredCount :: Maybe Int
    , _ServiceLoadBalancers :: Maybe [LoadBalancer]
    , _ServiceRole :: Maybe Text
    , _ServicePlacementConstraints :: Maybe [PlacementConstraint]
    , _ServiceServiceName :: Maybe Text
    , _ServiceLaunchType :: Maybe Text
    , _ServiceTaskDefinition :: Text
    , _ServiceSchedulingStrategy :: Maybe Text
    , _ServiceServiceRegistries :: Maybe [ServiceRegistry]
    , _ServiceHealthCheckGracePeriodSeconds :: Maybe Int
    , _ServiceNetworkConfiguration :: Maybe NetworkConfiguration
    , _ServiceDeploymentConfiguration :: Maybe DeploymentConfiguration
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''PlacementConstraint)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''LoadBalancer)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''DeploymentConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''NetworkConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''ServiceRegistry)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''AwsVpcConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''PlacementStrategy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Service)

resourceJSON :: Service -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ECS::Service" :: Text), "Properties" .= a ]
