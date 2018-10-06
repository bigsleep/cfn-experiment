{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Redshift.ClusterSecurityGroupIngress
    ( ClusterSecurityGroupIngress(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ClusterSecurityGroupIngress = ClusterSecurityGroupIngress
    { _ClusterSecurityGroupIngressEC2SecurityGroupOwnerId :: Maybe Text
    , _ClusterSecurityGroupIngressClusterSecurityGroupName :: Text
    , _ClusterSecurityGroupIngressEC2SecurityGroupName :: Maybe Text
    , _ClusterSecurityGroupIngressCIDRIP :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 28 } ''ClusterSecurityGroupIngress)

resourceJSON :: ClusterSecurityGroupIngress -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Redshift::ClusterSecurityGroupIngress" :: Text), "Properties" .= a ]
