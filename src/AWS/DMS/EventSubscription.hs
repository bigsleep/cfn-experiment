{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.DMS.EventSubscription
    ( EventSubscription(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data EventSubscription = EventSubscription
    { _EventSubscriptionSubscriptionName :: Maybe Text
    , _EventSubscriptionSnsTopicArn :: Text
    , _EventSubscriptionEnabled :: Maybe Bool
    , _EventSubscriptionSourceType :: Maybe Text
    , _EventSubscriptionEventCategories :: Maybe [Text]
    , _EventSubscriptionSourceIds :: Maybe [Text]
    , _EventSubscriptionTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''EventSubscription)

resourceJSON :: EventSubscription -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::DMS::EventSubscription" :: Text), "Properties" .= a ]
