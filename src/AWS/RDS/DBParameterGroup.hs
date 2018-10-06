{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.RDS.DBParameterGroup
    ( DBParameterGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data DBParameterGroup = DBParameterGroup
    { _DBParameterGroupFamily :: Text
    , _DBParameterGroupParameters :: Maybe Map
    , _DBParameterGroupDescription :: Text
    , _DBParameterGroupTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''DBParameterGroup)

resourceJSON :: DBParameterGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::RDS::DBParameterGroup" :: Text), "Properties" .= a ]
