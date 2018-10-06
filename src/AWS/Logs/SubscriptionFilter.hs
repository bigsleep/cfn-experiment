{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Logs.SubscriptionFilter
    ( SubscriptionFilter(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SubscriptionFilter = SubscriptionFilter
    { _SubscriptionFilterDestinationArn :: Text
    , _SubscriptionFilterLogGroupName :: Text
    , _SubscriptionFilterFilterPattern :: Text
    , _SubscriptionFilterRoleArn :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''SubscriptionFilter)

resourceJSON :: SubscriptionFilter -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Logs::SubscriptionFilter" :: Text), "Properties" .= a ]
