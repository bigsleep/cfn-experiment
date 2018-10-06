{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ECS.Cluster
    ( Cluster(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Cluster = Cluster
    { _ClusterClusterName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Cluster)

resourceJSON :: Cluster -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ECS::Cluster" :: Text), "Properties" .= a ]
