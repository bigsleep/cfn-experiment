{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.NatGateway
    ( NatGateway(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data NatGateway = NatGateway
    { _NatGatewayAllocationId :: Text
    , _NatGatewaySubnetId :: Text
    , _NatGatewayTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''NatGateway)

resourceJSON :: NatGateway -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::NatGateway" :: Text), "Properties" .= a ]
