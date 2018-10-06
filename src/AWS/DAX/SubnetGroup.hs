{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.DAX.SubnetGroup
    ( SubnetGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SubnetGroup = SubnetGroup
    { _SubnetGroupSubnetIds :: [Text]
    , _SubnetGroupSubnetGroupName :: Maybe Text
    , _SubnetGroupDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''SubnetGroup)

resourceJSON :: SubnetGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::DAX::SubnetGroup" :: Text), "Properties" .= a ]
