{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Glue.Job
    ( ConnectionsList(..)
    , JobCommand(..)
    , ExecutionProperty(..)
    , Job(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ConnectionsList = ConnectionsList
    { _ConnectionsListConnections :: Maybe [Text]
    } deriving (Show, Eq)

data JobCommand = JobCommand
    { _JobCommandScriptLocation :: Maybe Text
    , _JobCommandName :: Maybe Text
    } deriving (Show, Eq)

data ExecutionProperty = ExecutionProperty
    { _ExecutionPropertyMaxConcurrentRuns :: Maybe Double
    } deriving (Show, Eq)

data Job = Job
    { _JobCommand :: JobCommand
    , _JobConnections :: Maybe ConnectionsList
    , _JobRole :: Text
    , _JobName :: Maybe Text
    , _JobLogUri :: Maybe Text
    , _JobMaxRetries :: Maybe Double
    , _JobExecutionProperty :: Maybe ExecutionProperty
    , _JobAllocatedCapacity :: Maybe Double
    , _JobDefaultArguments :: Maybe DA.Value
    , _JobDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''ConnectionsList)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''JobCommand)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''ExecutionProperty)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 4 } ''Job)

resourceJSON :: Job -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Glue::Job" :: Text), "Properties" .= a ]
