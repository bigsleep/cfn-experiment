{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SNS.Subscription
    ( Subscription(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Subscription = Subscription
    { _SubscriptionFilterPolicy :: Maybe DA.Value
    , _SubscriptionProtocol :: Maybe Text
    , _SubscriptionTopicArn :: Maybe Text
    , _SubscriptionDeliveryPolicy :: Maybe DA.Value
    , _SubscriptionRegion :: Maybe Text
    , _SubscriptionEndpoint :: Maybe Text
    , _SubscriptionRawMessageDelivery :: Maybe Bool
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''Subscription)

resourceJSON :: Subscription -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SNS::Subscription" :: Text), "Properties" .= a ]
