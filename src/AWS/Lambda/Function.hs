{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Lambda.Function
    ( TracingConfig(..)
    , Environment(..)
    , Code(..)
    , DeadLetterConfig(..)
    , VpcConfig(..)
    , Function(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data TracingConfig = TracingConfig
    { _TracingConfigMode :: Maybe Text
    } deriving (Show, Eq)

data Environment = Environment
    { _EnvironmentVariables :: Maybe Map
    } deriving (Show, Eq)

data Code = Code
    { _CodeS3ObjectVersion :: Maybe Text
    , _CodeS3Key :: Maybe Text
    , _CodeZipFile :: Maybe Text
    , _CodeS3Bucket :: Maybe Text
    } deriving (Show, Eq)

data DeadLetterConfig = DeadLetterConfig
    { _DeadLetterConfigTargetArn :: Maybe Text
    } deriving (Show, Eq)

data VpcConfig = VpcConfig
    { _VpcConfigSecurityGroupIds :: [Text]
    , _VpcConfigSubnetIds :: [Text]
    } deriving (Show, Eq)

data Function = Function
    { _FunctionMemorySize :: Maybe Int
    , _FunctionRuntime :: Text
    , _FunctionKmsKeyArn :: Maybe Text
    , _FunctionEnvironment :: Maybe Environment
    , _FunctionDeadLetterConfig :: Maybe DeadLetterConfig
    , _FunctionReservedConcurrentExecutions :: Maybe Int
    , _FunctionRole :: Text
    , _FunctionVpcConfig :: Maybe VpcConfig
    , _FunctionFunctionName :: Maybe Text
    , _FunctionCode :: Code
    , _FunctionHandler :: Text
    , _FunctionTimeout :: Maybe Int
    , _FunctionTracingConfig :: Maybe TracingConfig
    , _FunctionDescription :: Maybe Text
    , _FunctionTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''TracingConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Environment)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 5 } ''Code)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''DeadLetterConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''VpcConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Function)

resourceJSON :: Function -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Lambda::Function" :: Text), "Properties" .= a ]
