{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.NetworkAclEntry
    ( Icmp(..)
    , PortRange(..)
    , NetworkAclEntry(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Icmp = Icmp
    { _IcmpCode :: Maybe Int
    , _IcmpType :: Maybe Int
    } deriving (Show, Eq)

data PortRange = PortRange
    { _PortRangeTo :: Maybe Int
    , _PortRangeFrom :: Maybe Int
    } deriving (Show, Eq)

data NetworkAclEntry = NetworkAclEntry
    { _NetworkAclEntryIpv6CidrBlock :: Maybe Text
    , _NetworkAclEntryIcmp :: Maybe Icmp
    , _NetworkAclEntryNetworkAclId :: Text
    , _NetworkAclEntryRuleNumber :: Int
    , _NetworkAclEntryRuleAction :: Text
    , _NetworkAclEntryProtocol :: Int
    , _NetworkAclEntryPortRange :: Maybe PortRange
    , _NetworkAclEntryCidrBlock :: Text
    , _NetworkAclEntryEgress :: Maybe Bool
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 5 } ''Icmp)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''PortRange)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''NetworkAclEntry)

resourceJSON :: NetworkAclEntry -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::NetworkAclEntry" :: Text), "Properties" .= a ]
