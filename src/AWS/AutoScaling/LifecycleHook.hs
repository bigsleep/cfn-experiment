{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.AutoScaling.LifecycleHook
    ( LifecycleHook(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data LifecycleHook = LifecycleHook
    { _LifecycleHookDefaultResult :: Maybe Text
    , _LifecycleHookLifecycleHookName :: Maybe Text
    , _LifecycleHookHeartbeatTimeout :: Maybe Int
    , _LifecycleHookAutoScalingGroupName :: Text
    , _LifecycleHookNotificationMetadata :: Maybe Text
    , _LifecycleHookNotificationTargetARN :: Maybe Text
    , _LifecycleHookLifecycleTransition :: Text
    , _LifecycleHookRoleARN :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''LifecycleHook)

resourceJSON :: LifecycleHook -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::AutoScaling::LifecycleHook" :: Text), "Properties" .= a ]
