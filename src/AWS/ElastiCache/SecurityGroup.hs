{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ElastiCache.SecurityGroup
    ( SecurityGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SecurityGroup = SecurityGroup
    { _SecurityGroupDescription :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''SecurityGroup)

resourceJSON :: SecurityGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ElastiCache::SecurityGroup" :: Text), "Properties" .= a ]
