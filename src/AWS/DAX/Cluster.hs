{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.DAX.Cluster
    ( SSESpecification(..)
    , Cluster(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SSESpecification = SSESpecification
    { _SSESpecificationSSEEnabled :: Maybe Bool
    } deriving (Show, Eq)

data Cluster = Cluster
    { _ClusterIAMRoleARN :: Text
    , _ClusterSecurityGroupIds :: Maybe [Text]
    , _ClusterSSESpecification :: Maybe SSESpecification
    , _ClusterSubnetGroupName :: Maybe Text
    , _ClusterPreferredMaintenanceWindow :: Maybe Text
    , _ClusterAvailabilityZones :: Maybe [Text]
    , _ClusterClusterName :: Maybe Text
    , _ClusterNodeType :: Text
    , _ClusterDescription :: Maybe Text
    , _ClusterReplicationFactor :: Int
    , _ClusterNotificationTopicARN :: Maybe Text
    , _ClusterTags :: Maybe DA.Value
    , _ClusterParameterGroupName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''SSESpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Cluster)

resourceJSON :: Cluster -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::DAX::Cluster" :: Text), "Properties" .= a ]
