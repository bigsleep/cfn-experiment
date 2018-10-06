{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.RDS.DBSecurityGroup
    ( Ingress(..)
    , DBSecurityGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Ingress = Ingress
    { _IngressEC2SecurityGroupOwnerId :: Maybe Text
    , _IngressEC2SecurityGroupName :: Maybe Text
    , _IngressCIDRIP :: Maybe Text
    , _IngressEC2SecurityGroupId :: Maybe Text
    } deriving (Show, Eq)

data DBSecurityGroup = DBSecurityGroup
    { _DBSecurityGroupEC2VpcId :: Maybe Text
    , _DBSecurityGroupDBSecurityGroupIngress :: [Ingress]
    , _DBSecurityGroupTags :: Maybe [Tag]
    , _DBSecurityGroupGroupDescription :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Ingress)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''DBSecurityGroup)

resourceJSON :: DBSecurityGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::RDS::DBSecurityGroup" :: Text), "Properties" .= a ]
