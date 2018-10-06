{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.DMS.ReplicationSubnetGroup
    ( ReplicationSubnetGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ReplicationSubnetGroup = ReplicationSubnetGroup
    { _ReplicationSubnetGroupSubnetIds :: [Text]
    , _ReplicationSubnetGroupReplicationSubnetGroupIdentifier :: Maybe Text
    , _ReplicationSubnetGroupReplicationSubnetGroupDescription :: Text
    , _ReplicationSubnetGroupTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 23 } ''ReplicationSubnetGroup)

resourceJSON :: ReplicationSubnetGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::DMS::ReplicationSubnetGroup" :: Text), "Properties" .= a ]
