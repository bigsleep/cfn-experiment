{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.GuardDuty.ThreatIntelSet
    ( ThreatIntelSet(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ThreatIntelSet = ThreatIntelSet
    { _ThreatIntelSetLocation :: Text
    , _ThreatIntelSetFormat :: Text
    , _ThreatIntelSetActivate :: Bool
    , _ThreatIntelSetDetectorId :: Text
    , _ThreatIntelSetName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''ThreatIntelSet)

resourceJSON :: ThreatIntelSet -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::GuardDuty::ThreatIntelSet" :: Text), "Properties" .= a ]
