{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CloudFormation.CustomResource
    ( CustomResource(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data CustomResource = CustomResource
    { _CustomResourceServiceToken :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''CustomResource)

resourceJSON :: CustomResource -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CloudFormation::CustomResource" :: Text), "Properties" .= a ]
