{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Redshift.ClusterSecurityGroup
    ( ClusterSecurityGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ClusterSecurityGroup = ClusterSecurityGroup
    { _ClusterSecurityGroupDescription :: Text
    , _ClusterSecurityGroupTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''ClusterSecurityGroup)

resourceJSON :: ClusterSecurityGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Redshift::ClusterSecurityGroup" :: Text), "Properties" .= a ]
