{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.AutoScaling.ScheduledAction
    ( ScheduledAction(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ScheduledAction = ScheduledAction
    { _ScheduledActionStartTime :: Maybe Text
    , _ScheduledActionMaxSize :: Maybe Int
    , _ScheduledActionRecurrence :: Maybe Text
    , _ScheduledActionDesiredCapacity :: Maybe Int
    , _ScheduledActionMinSize :: Maybe Int
    , _ScheduledActionAutoScalingGroupName :: Text
    , _ScheduledActionEndTime :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''ScheduledAction)

resourceJSON :: ScheduledAction -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::AutoScaling::ScheduledAction" :: Text), "Properties" .= a ]
