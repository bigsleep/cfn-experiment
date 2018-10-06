{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.AppSync.GraphQLSchema
    ( GraphQLSchema(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data GraphQLSchema = GraphQLSchema
    { _GraphQLSchemaApiId :: Text
    , _GraphQLSchemaDefinition :: Maybe Text
    , _GraphQLSchemaDefinitionS3Location :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''GraphQLSchema)

resourceJSON :: GraphQLSchema -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::AppSync::GraphQLSchema" :: Text), "Properties" .= a ]
