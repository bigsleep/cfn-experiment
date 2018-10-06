{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.NetworkInterface
    ( InstanceIpv6Address(..)
    , PrivateIpAddressSpecification(..)
    , NetworkInterface(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data InstanceIpv6Address = InstanceIpv6Address
    { _InstanceIpv6AddressIpv6Address :: Text
    } deriving (Show, Eq)

data PrivateIpAddressSpecification = PrivateIpAddressSpecification
    { _PrivateIpAddressSpecificationPrimary :: Bool
    , _PrivateIpAddressSpecificationPrivateIpAddress :: Text
    } deriving (Show, Eq)

data NetworkInterface = NetworkInterface
    { _NetworkInterfacePrivateIpAddresses :: Maybe [PrivateIpAddressSpecification]
    , _NetworkInterfaceSourceDestCheck :: Maybe Bool
    , _NetworkInterfaceInterfaceType :: Maybe Text
    , _NetworkInterfaceSubnetId :: Text
    , _NetworkInterfaceIpv6AddressCount :: Maybe Int
    , _NetworkInterfacePrivateIpAddress :: Maybe Text
    , _NetworkInterfaceGroupSet :: Maybe [Text]
    , _NetworkInterfaceSecondaryPrivateIpAddressCount :: Maybe Int
    , _NetworkInterfaceDescription :: Maybe Text
    , _NetworkInterfaceTags :: Maybe [Tag]
    , _NetworkInterfaceIpv6Addresses :: Maybe InstanceIpv6Address
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''InstanceIpv6Address)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''PrivateIpAddressSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''NetworkInterface)

resourceJSON :: NetworkInterface -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::NetworkInterface" :: Text), "Properties" .= a ]
