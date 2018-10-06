{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Redshift.ClusterParameterGroup
    ( Parameter(..)
    , ClusterParameterGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Parameter = Parameter
    { _ParameterParameterValue :: Text
    , _ParameterParameterName :: Text
    } deriving (Show, Eq)

data ClusterParameterGroup = ClusterParameterGroup
    { _ClusterParameterGroupParameters :: Maybe [Parameter]
    , _ClusterParameterGroupParameterGroupFamily :: Text
    , _ClusterParameterGroupDescription :: Text
    , _ClusterParameterGroupTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Parameter)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''ClusterParameterGroup)

resourceJSON :: ClusterParameterGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Redshift::ClusterParameterGroup" :: Text), "Properties" .= a ]
