{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.SecurityGroupIngress
    ( SecurityGroupIngress(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SecurityGroupIngress = SecurityGroupIngress
    { _SecurityGroupIngressFromPort :: Maybe Int
    , _SecurityGroupIngressIpProtocol :: Text
    , _SecurityGroupIngressGroupId :: Maybe Text
    , _SecurityGroupIngressToPort :: Maybe Int
    , _SecurityGroupIngressCidrIp :: Maybe Text
    , _SecurityGroupIngressCidrIpv6 :: Maybe Text
    , _SecurityGroupIngressSourceSecurityGroupOwnerId :: Maybe Text
    , _SecurityGroupIngressGroupName :: Maybe Text
    , _SecurityGroupIngressSourceSecurityGroupName :: Maybe Text
    , _SecurityGroupIngressDescription :: Maybe Text
    , _SecurityGroupIngressSourceSecurityGroupId :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''SecurityGroupIngress)

resourceJSON :: SecurityGroupIngress -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::SecurityGroupIngress" :: Text), "Properties" .= a ]
