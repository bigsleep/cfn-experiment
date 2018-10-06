{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.Subnet
    ( Subnet(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Subnet = Subnet
    { _SubnetIpv6CidrBlock :: Maybe Text
    , _SubnetVpcId :: Text
    , _SubnetAssignIpv6AddressOnCreation :: Maybe Bool
    , _SubnetAvailabilityZone :: Maybe Text
    , _SubnetCidrBlock :: Text
    , _SubnetMapPublicIpOnLaunch :: Maybe Bool
    , _SubnetTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Subnet)

resourceJSON :: Subnet -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::Subnet" :: Text), "Properties" .= a ]
