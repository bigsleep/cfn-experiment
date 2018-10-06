{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ElasticLoadBalancingV2.LoadBalancer
    ( SubnetMapping(..)
    , LoadBalancerAttribute(..)
    , LoadBalancer(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SubnetMapping = SubnetMapping
    { _SubnetMappingAllocationId :: Text
    , _SubnetMappingSubnetId :: Text
    } deriving (Show, Eq)

data LoadBalancerAttribute = LoadBalancerAttribute
    { _LoadBalancerAttributeValue :: Maybe Text
    , _LoadBalancerAttributeKey :: Maybe Text
    } deriving (Show, Eq)

data LoadBalancer = LoadBalancer
    { _LoadBalancerSubnetMappings :: Maybe [SubnetMapping]
    , _LoadBalancerSecurityGroups :: Maybe [Text]
    , _LoadBalancerLoadBalancerAttributes :: Maybe [LoadBalancerAttribute]
    , _LoadBalancerSubnets :: Maybe [Text]
    , _LoadBalancerIpAddressType :: Maybe Text
    , _LoadBalancerName :: Maybe Text
    , _LoadBalancerScheme :: Maybe Text
    , _LoadBalancerType :: Maybe Text
    , _LoadBalancerTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''SubnetMapping)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''LoadBalancerAttribute)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''LoadBalancer)

resourceJSON :: LoadBalancer -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ElasticLoadBalancingV2::LoadBalancer" :: Text), "Properties" .= a ]
