{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.DAX.ParameterGroup
    ( ParameterGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ParameterGroup = ParameterGroup
    { _ParameterGroupParameterNameValues :: Maybe DA.Value
    , _ParameterGroupDescription :: Maybe Text
    , _ParameterGroupParameterGroupName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''ParameterGroup)

resourceJSON :: ParameterGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::DAX::ParameterGroup" :: Text), "Properties" .= a ]
