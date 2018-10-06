{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.RDS.DBSecurityGroupIngress
    ( DBSecurityGroupIngress(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data DBSecurityGroupIngress = DBSecurityGroupIngress
    { _DBSecurityGroupIngressEC2SecurityGroupOwnerId :: Maybe Text
    , _DBSecurityGroupIngressEC2SecurityGroupName :: Maybe Text
    , _DBSecurityGroupIngressCIDRIP :: Maybe Text
    , _DBSecurityGroupIngressDBSecurityGroupName :: Text
    , _DBSecurityGroupIngressEC2SecurityGroupId :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 23 } ''DBSecurityGroupIngress)

resourceJSON :: DBSecurityGroupIngress -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::RDS::DBSecurityGroupIngress" :: Text), "Properties" .= a ]
