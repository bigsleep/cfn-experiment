{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.VPCPeeringConnection
    ( VPCPeeringConnection(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VPCPeeringConnection = VPCPeeringConnection
    { _VPCPeeringConnectionPeerVpcId :: Text
    , _VPCPeeringConnectionVpcId :: Text
    , _VPCPeeringConnectionPeerOwnerId :: Maybe Text
    , _VPCPeeringConnectionPeerRegion :: Maybe Text
    , _VPCPeeringConnectionPeerRoleArn :: Maybe Text
    , _VPCPeeringConnectionTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''VPCPeeringConnection)

resourceJSON :: VPCPeeringConnection -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::VPCPeeringConnection" :: Text), "Properties" .= a ]
