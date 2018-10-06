{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Events.Rule
    ( EcsParameters(..)
    , Target(..)
    , RunCommandParameters(..)
    , InputTransformer(..)
    , RunCommandTarget(..)
    , KinesisParameters(..)
    , SqsParameters(..)
    , Rule(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data EcsParameters = EcsParameters
    { _EcsParametersTaskDefinitionArn :: Text
    , _EcsParametersTaskCount :: Maybe Int
    } deriving (Show, Eq)

data Target = Target
    { _TargetRunCommandParameters :: Maybe RunCommandParameters
    , _TargetKinesisParameters :: Maybe KinesisParameters
    , _TargetArn :: Text
    , _TargetInputTransformer :: Maybe InputTransformer
    , _TargetSqsParameters :: Maybe SqsParameters
    , _TargetInput :: Maybe Text
    , _TargetEcsParameters :: Maybe EcsParameters
    , _TargetId :: Text
    , _TargetInputPath :: Maybe Text
    , _TargetRoleArn :: Maybe Text
    } deriving (Show, Eq)

data RunCommandParameters = RunCommandParameters
    { _RunCommandParametersRunCommandTargets :: [RunCommandTarget]
    } deriving (Show, Eq)

data InputTransformer = InputTransformer
    { _InputTransformerInputPathsMap :: Maybe Map
    , _InputTransformerInputTemplate :: Text
    } deriving (Show, Eq)

data RunCommandTarget = RunCommandTarget
    { _RunCommandTargetValues :: [Text]
    , _RunCommandTargetKey :: Text
    } deriving (Show, Eq)

data KinesisParameters = KinesisParameters
    { _KinesisParametersPartitionKeyPath :: Text
    } deriving (Show, Eq)

data SqsParameters = SqsParameters
    { _SqsParametersMessageGroupId :: Text
    } deriving (Show, Eq)

data Rule = Rule
    { _RuleEventPattern :: Maybe DA.Value
    , _RuleState :: Maybe Text
    , _RuleScheduleExpression :: Maybe Text
    , _RuleName :: Maybe Text
    , _RuleTargets :: Maybe [Target]
    , _RuleDescription :: Maybe Text
    , _RuleRoleArn :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''EcsParameters)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Target)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''RunCommandParameters)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''InputTransformer)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''RunCommandTarget)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''KinesisParameters)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''SqsParameters)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 5 } ''Rule)

resourceJSON :: Rule -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Events::Rule" :: Text), "Properties" .= a ]
