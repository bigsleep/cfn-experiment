{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.AppSync.DataSource
    ( DynamoDBConfig(..)
    , HttpConfig(..)
    , LambdaConfig(..)
    , ElasticsearchConfig(..)
    , DataSource(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data DynamoDBConfig = DynamoDBConfig
    { _DynamoDBConfigUseCallerCredentials :: Maybe Bool
    , _DynamoDBConfigAwsRegion :: Text
    , _DynamoDBConfigTableName :: Text
    } deriving (Show, Eq)

data HttpConfig = HttpConfig
    { _HttpConfigEndpoint :: Text
    } deriving (Show, Eq)

data LambdaConfig = LambdaConfig
    { _LambdaConfigLambdaFunctionArn :: Text
    } deriving (Show, Eq)

data ElasticsearchConfig = ElasticsearchConfig
    { _ElasticsearchConfigAwsRegion :: Text
    , _ElasticsearchConfigEndpoint :: Text
    } deriving (Show, Eq)

data DataSource = DataSource
    { _DataSourceServiceRoleArn :: Maybe Text
    , _DataSourceApiId :: Text
    , _DataSourceDynamoDBConfig :: Maybe DynamoDBConfig
    , _DataSourceName :: Text
    , _DataSourceHttpConfig :: Maybe HttpConfig
    , _DataSourceLambdaConfig :: Maybe LambdaConfig
    , _DataSourceType :: Text
    , _DataSourceDescription :: Maybe Text
    , _DataSourceElasticsearchConfig :: Maybe ElasticsearchConfig
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''DynamoDBConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''HttpConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''LambdaConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''ElasticsearchConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''DataSource)

resourceJSON :: DataSource -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::AppSync::DataSource" :: Text), "Properties" .= a ]
