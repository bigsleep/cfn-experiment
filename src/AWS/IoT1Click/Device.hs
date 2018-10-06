{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IoT1Click.Device
    ( Device(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Device = Device
    { _DeviceEnabled :: Bool
    , _DeviceDeviceId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Device)

resourceJSON :: Device -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IoT1Click::Device" :: Text), "Properties" .= a ]
