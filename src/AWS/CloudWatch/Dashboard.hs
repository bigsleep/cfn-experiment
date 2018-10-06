{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CloudWatch.Dashboard
    ( Dashboard(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Dashboard = Dashboard
    { _DashboardDashboardName :: Maybe Text
    , _DashboardDashboardBody :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Dashboard)

resourceJSON :: Dashboard -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CloudWatch::Dashboard" :: Text), "Properties" .= a ]
