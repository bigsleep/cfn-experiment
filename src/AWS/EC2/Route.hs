{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.Route
    ( Route(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Route = Route
    { _RouteVpcPeeringConnectionId :: Maybe Text
    , _RouteInstanceId :: Maybe Text
    , _RouteEgressOnlyInternetGatewayId :: Maybe Text
    , _RouteRouteTableId :: Text
    , _RouteDestinationIpv6CidrBlock :: Maybe Text
    , _RouteNatGatewayId :: Maybe Text
    , _RouteNetworkInterfaceId :: Maybe Text
    , _RouteGatewayId :: Maybe Text
    , _RouteDestinationCidrBlock :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Route)

resourceJSON :: Route -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::Route" :: Text), "Properties" .= a ]
