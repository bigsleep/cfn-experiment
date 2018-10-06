{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Batch.JobQueue
    ( ComputeEnvironmentOrder(..)
    , JobQueue(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ComputeEnvironmentOrder = ComputeEnvironmentOrder
    { _ComputeEnvironmentOrderComputeEnvironment :: Text
    , _ComputeEnvironmentOrderOrder :: Int
    } deriving (Show, Eq)

data JobQueue = JobQueue
    { _JobQueueState :: Maybe Text
    , _JobQueuePriority :: Int
    , _JobQueueComputeEnvironmentOrder :: [ComputeEnvironmentOrder]
    , _JobQueueJobQueueName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''ComputeEnvironmentOrder)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''JobQueue)

resourceJSON :: JobQueue -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Batch::JobQueue" :: Text), "Properties" .= a ]
