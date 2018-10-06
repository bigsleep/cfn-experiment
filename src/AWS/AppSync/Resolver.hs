{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.AppSync.Resolver
    ( Resolver(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Resolver = Resolver
    { _ResolverTypeName :: Text
    , _ResolverResponseMappingTemplateS3Location :: Maybe Text
    , _ResolverDataSourceName :: Text
    , _ResolverApiId :: Text
    , _ResolverRequestMappingTemplate :: Maybe Text
    , _ResolverResponseMappingTemplate :: Maybe Text
    , _ResolverFieldName :: Text
    , _ResolverRequestMappingTemplateS3Location :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Resolver)

resourceJSON :: Resolver -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::AppSync::Resolver" :: Text), "Properties" .= a ]
