{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EMR.Step
    ( KeyValue(..)
    , HadoopJarStepConfig(..)
    , Step(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data KeyValue = KeyValue
    { _KeyValueValue :: Maybe Text
    , _KeyValueKey :: Maybe Text
    } deriving (Show, Eq)

data HadoopJarStepConfig = HadoopJarStepConfig
    { _HadoopJarStepConfigArgs :: Maybe [Text]
    , _HadoopJarStepConfigStepProperties :: Maybe [KeyValue]
    , _HadoopJarStepConfigJar :: Text
    , _HadoopJarStepConfigMainClass :: Maybe Text
    } deriving (Show, Eq)

data Step = Step
    { _StepActionOnFailure :: Text
    , _StepJobFlowId :: Text
    , _StepHadoopJarStep :: HadoopJarStepConfig
    , _StepName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''KeyValue)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''HadoopJarStepConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 5 } ''Step)

resourceJSON :: Step -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EMR::Step" :: Text), "Properties" .= a ]
