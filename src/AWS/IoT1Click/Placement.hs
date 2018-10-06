{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IoT1Click.Placement
    ( Placement(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Placement = Placement
    { _PlacementAssociatedDevices :: Maybe DA.Value
    , _PlacementAttributes :: Maybe DA.Value
    , _PlacementProjectName :: Text
    , _PlacementPlacementName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Placement)

resourceJSON :: Placement -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IoT1Click::Placement" :: Text), "Properties" .= a ]
