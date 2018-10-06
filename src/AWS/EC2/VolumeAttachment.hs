{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.VolumeAttachment
    ( VolumeAttachment(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VolumeAttachment = VolumeAttachment
    { _VolumeAttachmentInstanceId :: Text
    , _VolumeAttachmentDevice :: Text
    , _VolumeAttachmentVolumeId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''VolumeAttachment)

resourceJSON :: VolumeAttachment -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::VolumeAttachment" :: Text), "Properties" .= a ]
