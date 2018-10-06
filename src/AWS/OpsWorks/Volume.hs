{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.OpsWorks.Volume
    ( Volume(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Volume = Volume
    { _VolumeName :: Maybe Text
    , _VolumeStackId :: Text
    , _VolumeEc2VolumeId :: Text
    , _VolumeMountPoint :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Volume)

resourceJSON :: Volume -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::OpsWorks::Volume" :: Text), "Properties" .= a ]
