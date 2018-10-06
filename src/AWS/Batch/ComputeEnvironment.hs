{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Batch.ComputeEnvironment
    ( ComputeResources(..)
    , ComputeEnvironment(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ComputeResources = ComputeResources
    { _ComputeResourcesSecurityGroupIds :: [Text]
    , _ComputeResourcesInstanceTypes :: [Text]
    , _ComputeResourcesInstanceRole :: Text
    , _ComputeResourcesSubnets :: [Text]
    , _ComputeResourcesEc2KeyPair :: Maybe Text
    , _ComputeResourcesMinvCpus :: Int
    , _ComputeResourcesBidPercentage :: Maybe Int
    , _ComputeResourcesMaxvCpus :: Int
    , _ComputeResourcesSpotIamFleetRole :: Maybe Text
    , _ComputeResourcesImageId :: Maybe Text
    , _ComputeResourcesType :: Text
    , _ComputeResourcesDesiredvCpus :: Maybe Int
    , _ComputeResourcesTags :: Maybe DA.Value
    } deriving (Show, Eq)

data ComputeEnvironment = ComputeEnvironment
    { _ComputeEnvironmentState :: Maybe Text
    , _ComputeEnvironmentComputeEnvironmentName :: Maybe Text
    , _ComputeEnvironmentComputeResources :: Maybe ComputeResources
    , _ComputeEnvironmentType :: Text
    , _ComputeEnvironmentServiceRole :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''ComputeResources)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''ComputeEnvironment)

resourceJSON :: ComputeEnvironment -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Batch::ComputeEnvironment" :: Text), "Properties" .= a ]
