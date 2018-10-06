{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.VPCGatewayAttachment
    ( VPCGatewayAttachment(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VPCGatewayAttachment = VPCGatewayAttachment
    { _VPCGatewayAttachmentVpnGatewayId :: Maybe Text
    , _VPCGatewayAttachmentVpcId :: Text
    , _VPCGatewayAttachmentInternetGatewayId :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''VPCGatewayAttachment)

resourceJSON :: VPCGatewayAttachment -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::VPCGatewayAttachment" :: Text), "Properties" .= a ]
