{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CodeDeploy.DeploymentConfig
    ( MinimumHealthyHosts(..)
    , DeploymentConfig(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data MinimumHealthyHosts = MinimumHealthyHosts
    { _MinimumHealthyHostsValue :: Int
    , _MinimumHealthyHostsType :: Text
    } deriving (Show, Eq)

data DeploymentConfig = DeploymentConfig
    { _DeploymentConfigDeploymentConfigName :: Maybe Text
    , _DeploymentConfigMinimumHealthyHosts :: Maybe MinimumHealthyHosts
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''MinimumHealthyHosts)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''DeploymentConfig)

resourceJSON :: DeploymentConfig -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CodeDeploy::DeploymentConfig" :: Text), "Properties" .= a ]
