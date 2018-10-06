{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.SecurityGroup
    ( Egress(..)
    , Ingress(..)
    , SecurityGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Egress = Egress
    { _EgressFromPort :: Maybe Int
    , _EgressIpProtocol :: Text
    , _EgressToPort :: Maybe Int
    , _EgressCidrIp :: Maybe Text
    , _EgressCidrIpv6 :: Maybe Text
    , _EgressDestinationSecurityGroupId :: Maybe Text
    , _EgressDestinationPrefixListId :: Maybe Text
    , _EgressDescription :: Maybe Text
    } deriving (Show, Eq)

data Ingress = Ingress
    { _IngressFromPort :: Maybe Int
    , _IngressIpProtocol :: Text
    , _IngressToPort :: Maybe Int
    , _IngressCidrIp :: Maybe Text
    , _IngressCidrIpv6 :: Maybe Text
    , _IngressSourceSecurityGroupOwnerId :: Maybe Text
    , _IngressSourceSecurityGroupName :: Maybe Text
    , _IngressDescription :: Maybe Text
    , _IngressSourceSecurityGroupId :: Maybe Text
    } deriving (Show, Eq)

data SecurityGroup = SecurityGroup
    { _SecurityGroupVpcId :: Maybe Text
    , _SecurityGroupSecurityGroupEgress :: Maybe [Egress]
    , _SecurityGroupGroupName :: Maybe Text
    , _SecurityGroupSecurityGroupIngress :: Maybe [Ingress]
    , _SecurityGroupTags :: Maybe [Tag]
    , _SecurityGroupGroupDescription :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Egress)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Ingress)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''SecurityGroup)

resourceJSON :: SecurityGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::SecurityGroup" :: Text), "Properties" .= a ]
