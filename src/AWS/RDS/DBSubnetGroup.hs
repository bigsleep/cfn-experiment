{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.RDS.DBSubnetGroup
    ( DBSubnetGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data DBSubnetGroup = DBSubnetGroup
    { _DBSubnetGroupDBSubnetGroupName :: Maybe Text
    , _DBSubnetGroupSubnetIds :: [Text]
    , _DBSubnetGroupDBSubnetGroupDescription :: Text
    , _DBSubnetGroupTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''DBSubnetGroup)

resourceJSON :: DBSubnetGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::RDS::DBSubnetGroup" :: Text), "Properties" .= a ]
