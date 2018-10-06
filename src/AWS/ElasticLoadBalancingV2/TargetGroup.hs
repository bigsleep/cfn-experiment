{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ElasticLoadBalancingV2.TargetGroup
    ( Matcher(..)
    , TargetGroupAttribute(..)
    , TargetDescription(..)
    , TargetGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Matcher = Matcher
    { _MatcherHttpCode :: Text
    } deriving (Show, Eq)

data TargetGroupAttribute = TargetGroupAttribute
    { _TargetGroupAttributeValue :: Maybe Text
    , _TargetGroupAttributeKey :: Maybe Text
    } deriving (Show, Eq)

data TargetDescription = TargetDescription
    { _TargetDescriptionAvailabilityZone :: Maybe Text
    , _TargetDescriptionId :: Text
    , _TargetDescriptionPort :: Maybe Int
    } deriving (Show, Eq)

data TargetGroup = TargetGroup
    { _TargetGroupMatcher :: Maybe Matcher
    , _TargetGroupHealthCheckPath :: Maybe Text
    , _TargetGroupUnhealthyThresholdCount :: Maybe Int
    , _TargetGroupVpcId :: Text
    , _TargetGroupProtocol :: Text
    , _TargetGroupHealthCheckIntervalSeconds :: Maybe Int
    , _TargetGroupTargetType :: Maybe Text
    , _TargetGroupHealthyThresholdCount :: Maybe Int
    , _TargetGroupHealthCheckProtocol :: Maybe Text
    , _TargetGroupName :: Maybe Text
    , _TargetGroupTargets :: Maybe [TargetDescription]
    , _TargetGroupHealthCheckTimeoutSeconds :: Maybe Int
    , _TargetGroupHealthCheckPort :: Maybe Text
    , _TargetGroupTags :: Maybe [Tag]
    , _TargetGroupPort :: Int
    , _TargetGroupTargetGroupAttributes :: Maybe [TargetGroupAttribute]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Matcher)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''TargetGroupAttribute)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''TargetDescription)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''TargetGroup)

resourceJSON :: TargetGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ElasticLoadBalancingV2::TargetGroup" :: Text), "Properties" .= a ]
