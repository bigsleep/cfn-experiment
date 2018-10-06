{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.VPNGatewayRoutePropagation
    ( VPNGatewayRoutePropagation(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VPNGatewayRoutePropagation = VPNGatewayRoutePropagation
    { _VPNGatewayRoutePropagationVpnGatewayId :: Text
    , _VPNGatewayRoutePropagationRouteTableIds :: [Text]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 27 } ''VPNGatewayRoutePropagation)

resourceJSON :: VPNGatewayRoutePropagation -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::VPNGatewayRoutePropagation" :: Text), "Properties" .= a ]
