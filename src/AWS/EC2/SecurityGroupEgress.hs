{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.SecurityGroupEgress
    ( SecurityGroupEgress(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SecurityGroupEgress = SecurityGroupEgress
    { _SecurityGroupEgressFromPort :: Maybe Int
    , _SecurityGroupEgressIpProtocol :: Text
    , _SecurityGroupEgressGroupId :: Text
    , _SecurityGroupEgressToPort :: Maybe Int
    , _SecurityGroupEgressCidrIp :: Maybe Text
    , _SecurityGroupEgressCidrIpv6 :: Maybe Text
    , _SecurityGroupEgressDestinationSecurityGroupId :: Maybe Text
    , _SecurityGroupEgressDestinationPrefixListId :: Maybe Text
    , _SecurityGroupEgressDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''SecurityGroupEgress)

resourceJSON :: SecurityGroupEgress -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::SecurityGroupEgress" :: Text), "Properties" .= a ]
