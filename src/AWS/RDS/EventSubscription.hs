{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.RDS.EventSubscription
    ( EventSubscription(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data EventSubscription = EventSubscription
    { _EventSubscriptionSnsTopicArn :: Text
    , _EventSubscriptionEnabled :: Maybe Bool
    , _EventSubscriptionSourceType :: Maybe Text
    , _EventSubscriptionEventCategories :: Maybe [Text]
    , _EventSubscriptionSourceIds :: Maybe [Text]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''EventSubscription)

resourceJSON :: EventSubscription -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::RDS::EventSubscription" :: Text), "Properties" .= a ]
