{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.RDS.DBClusterParameterGroup
    ( DBClusterParameterGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data DBClusterParameterGroup = DBClusterParameterGroup
    { _DBClusterParameterGroupFamily :: Text
    , _DBClusterParameterGroupParameters :: DA.Value
    , _DBClusterParameterGroupDescription :: Text
    , _DBClusterParameterGroupTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''DBClusterParameterGroup)

resourceJSON :: DBClusterParameterGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::RDS::DBClusterParameterGroup" :: Text), "Properties" .= a ]
