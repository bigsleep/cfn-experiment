{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.VPCEndpoint
    ( VPCEndpoint(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VPCEndpoint = VPCEndpoint
    { _VPCEndpointPolicyDocument :: Maybe DA.Value
    , _VPCEndpointSecurityGroupIds :: Maybe [Text]
    , _VPCEndpointSubnetIds :: Maybe [Text]
    , _VPCEndpointVpcId :: Text
    , _VPCEndpointVPCEndpointType :: Maybe Text
    , _VPCEndpointServiceName :: Text
    , _VPCEndpointIsPrivateDnsEnabled :: Maybe Bool
    , _VPCEndpointRouteTableIds :: Maybe [Text]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''VPCEndpoint)

resourceJSON :: VPCEndpoint -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::VPCEndpoint" :: Text), "Properties" .= a ]
