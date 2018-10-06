{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.SubnetCidrBlock
    ( SubnetCidrBlock(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SubnetCidrBlock = SubnetCidrBlock
    { _SubnetCidrBlockIpv6CidrBlock :: Text
    , _SubnetCidrBlockSubnetId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''SubnetCidrBlock)

resourceJSON :: SubnetCidrBlock -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::SubnetCidrBlock" :: Text), "Properties" .= a ]
