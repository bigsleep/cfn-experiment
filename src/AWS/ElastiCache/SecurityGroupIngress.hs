{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ElastiCache.SecurityGroupIngress
    ( SecurityGroupIngress(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SecurityGroupIngress = SecurityGroupIngress
    { _SecurityGroupIngressCacheSecurityGroupName :: Text
    , _SecurityGroupIngressEC2SecurityGroupOwnerId :: Maybe Text
    , _SecurityGroupIngressEC2SecurityGroupName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''SecurityGroupIngress)

resourceJSON :: SecurityGroupIngress -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ElastiCache::SecurityGroupIngress" :: Text), "Properties" .= a ]
