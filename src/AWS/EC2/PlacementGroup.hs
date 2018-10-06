{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.PlacementGroup
    ( PlacementGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data PlacementGroup = PlacementGroup
    { _PlacementGroupStrategy :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''PlacementGroup)

resourceJSON :: PlacementGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::PlacementGroup" :: Text), "Properties" .= a ]
