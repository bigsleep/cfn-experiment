{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.RouteTable
    ( RouteTable(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data RouteTable = RouteTable
    { _RouteTableVpcId :: Text
    , _RouteTableTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''RouteTable)

resourceJSON :: RouteTable -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::RouteTable" :: Text), "Properties" .= a ]
