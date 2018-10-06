{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SNS.Topic
    ( Subscription(..)
    , Topic(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Subscription = Subscription
    { _SubscriptionProtocol :: Text
    , _SubscriptionEndpoint :: Text
    } deriving (Show, Eq)

data Topic = Topic
    { _TopicTopicName :: Maybe Text
    , _TopicDisplayName :: Maybe Text
    , _TopicSubscription :: Maybe [Subscription]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''Subscription)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Topic)

resourceJSON :: Topic -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SNS::Topic" :: Text), "Properties" .= a ]
