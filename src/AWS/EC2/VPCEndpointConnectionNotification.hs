{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.VPCEndpointConnectionNotification
    ( VPCEndpointConnectionNotification(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VPCEndpointConnectionNotification = VPCEndpointConnectionNotification
    { _VPCEndpointConnectionNotificationConnectionEvents :: [Text]
    , _VPCEndpointConnectionNotificationServiceId :: Maybe Text
    , _VPCEndpointConnectionNotificationVPCEndpointId :: Maybe Text
    , _VPCEndpointConnectionNotificationConnectionNotificationArn :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 34 } ''VPCEndpointConnectionNotification)

resourceJSON :: VPCEndpointConnectionNotification -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::VPCEndpointConnectionNotification" :: Text), "Properties" .= a ]
