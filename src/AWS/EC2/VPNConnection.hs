{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.VPNConnection
    ( VpnTunnelOptionsSpecification(..)
    , VPNConnection(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VpnTunnelOptionsSpecification = VpnTunnelOptionsSpecification
    { _VpnTunnelOptionsSpecificationTunnelInsideCidr :: Maybe Text
    , _VpnTunnelOptionsSpecificationPreSharedKey :: Maybe Text
    } deriving (Show, Eq)

data VPNConnection = VPNConnection
    { _VPNConnectionVpnGatewayId :: Text
    , _VPNConnectionVpnTunnelOptionsSpecifications :: Maybe [VpnTunnelOptionsSpecification]
    , _VPNConnectionCustomerGatewayId :: Text
    , _VPNConnectionType :: Text
    , _VPNConnectionStaticRoutesOnly :: Maybe Bool
    , _VPNConnectionTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''VpnTunnelOptionsSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''VPNConnection)

resourceJSON :: VPNConnection -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::VPNConnection" :: Text), "Properties" .= a ]
