{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IoT.ThingPrincipalAttachment
    ( ThingPrincipalAttachment(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ThingPrincipalAttachment = ThingPrincipalAttachment
    { _ThingPrincipalAttachmentPrincipal :: Text
    , _ThingPrincipalAttachmentThingName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 25 } ''ThingPrincipalAttachment)

resourceJSON :: ThingPrincipalAttachment -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IoT::ThingPrincipalAttachment" :: Text), "Properties" .= a ]
