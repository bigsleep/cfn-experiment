{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApplicationAutoScaling.ScalableTarget
    ( ScheduledAction(..)
    , ScalableTargetAction(..)
    , ScalableTarget(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ScheduledAction = ScheduledAction
    { _ScheduledActionStartTime :: Maybe Text
    , _ScheduledActionSchedule :: Text
    , _ScheduledActionScheduledActionName :: Text
    , _ScheduledActionEndTime :: Maybe Text
    , _ScheduledActionScalableTargetAction :: Maybe ScalableTargetAction
    } deriving (Show, Eq)

data ScalableTargetAction = ScalableTargetAction
    { _ScalableTargetActionMaxCapacity :: Maybe Int
    , _ScalableTargetActionMinCapacity :: Maybe Int
    } deriving (Show, Eq)

data ScalableTarget = ScalableTarget
    { _ScalableTargetScalableDimension :: Text
    , _ScalableTargetResourceId :: Text
    , _ScalableTargetServiceNamespace :: Text
    , _ScalableTargetScheduledActions :: Maybe [ScheduledAction]
    , _ScalableTargetMaxCapacity :: Int
    , _ScalableTargetMinCapacity :: Int
    , _ScalableTargetRoleARN :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''ScheduledAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''ScalableTargetAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''ScalableTarget)

resourceJSON :: ScalableTarget -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApplicationAutoScaling::ScalableTarget" :: Text), "Properties" .= a ]
