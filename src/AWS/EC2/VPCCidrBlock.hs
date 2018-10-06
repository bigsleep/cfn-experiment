{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.VPCCidrBlock
    ( VPCCidrBlock(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VPCCidrBlock = VPCCidrBlock
    { _VPCCidrBlockVpcId :: Text
    , _VPCCidrBlockCidrBlock :: Maybe Text
    , _VPCCidrBlockAmazonProvidedIpv6CidrBlock :: Maybe Bool
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''VPCCidrBlock)

resourceJSON :: VPCCidrBlock -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::VPCCidrBlock" :: Text), "Properties" .= a ]
