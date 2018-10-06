{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.VPNGateway
    ( VPNGateway(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VPNGateway = VPNGateway
    { _VPNGatewayAmazonSideAsn :: Maybe Integer
    , _VPNGatewayType :: Text
    , _VPNGatewayTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''VPNGateway)

resourceJSON :: VPNGateway -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::VPNGateway" :: Text), "Properties" .= a ]
