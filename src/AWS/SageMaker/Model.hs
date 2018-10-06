{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SageMaker.Model
    ( ContainerDefinition(..)
    , VpcConfig(..)
    , Model(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ContainerDefinition = ContainerDefinition
    { _ContainerDefinitionModelDataUrl :: Maybe Text
    , _ContainerDefinitionImage :: Text
    , _ContainerDefinitionEnvironment :: Maybe DA.Value
    , _ContainerDefinitionContainerHostname :: Maybe Text
    } deriving (Show, Eq)

data VpcConfig = VpcConfig
    { _VpcConfigSecurityGroupIds :: [Text]
    , _VpcConfigSubnets :: [Text]
    } deriving (Show, Eq)

data Model = Model
    { _ModelModelName :: Maybe Text
    , _ModelPrimaryContainer :: ContainerDefinition
    , _ModelExecutionRoleArn :: Text
    , _ModelVpcConfig :: Maybe VpcConfig
    , _ModelTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''ContainerDefinition)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''VpcConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Model)

resourceJSON :: Model -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SageMaker::Model" :: Text), "Properties" .= a ]
