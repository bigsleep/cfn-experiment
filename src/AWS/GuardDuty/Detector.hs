{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.GuardDuty.Detector
    ( Detector(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Detector = Detector
    { _DetectorEnable :: Bool
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Detector)

resourceJSON :: Detector -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::GuardDuty::Detector" :: Text), "Properties" .= a ]
