{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.AppSync.GraphQLApi
    ( LogConfig(..)
    , OpenIDConnectConfig(..)
    , UserPoolConfig(..)
    , GraphQLApi(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data LogConfig = LogConfig
    { _LogConfigFieldLogLevel :: Maybe Text
    , _LogConfigCloudWatchLogsRoleArn :: Maybe Text
    } deriving (Show, Eq)

data OpenIDConnectConfig = OpenIDConnectConfig
    { _OpenIDConnectConfigAuthTTL :: Maybe Double
    , _OpenIDConnectConfigClientId :: Maybe Text
    , _OpenIDConnectConfigIatTTL :: Maybe Double
    , _OpenIDConnectConfigIssuer :: Maybe Text
    } deriving (Show, Eq)

data UserPoolConfig = UserPoolConfig
    { _UserPoolConfigUserPoolId :: Maybe Text
    , _UserPoolConfigDefaultAction :: Maybe Text
    , _UserPoolConfigAwsRegion :: Maybe Text
    , _UserPoolConfigAppIdClientRegex :: Maybe Text
    } deriving (Show, Eq)

data GraphQLApi = GraphQLApi
    { _GraphQLApiOpenIDConnectConfig :: Maybe OpenIDConnectConfig
    , _GraphQLApiUserPoolConfig :: Maybe UserPoolConfig
    , _GraphQLApiName :: Text
    , _GraphQLApiAuthenticationType :: Text
    , _GraphQLApiLogConfig :: Maybe LogConfig
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''LogConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''OpenIDConnectConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''UserPoolConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''GraphQLApi)

resourceJSON :: GraphQLApi -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::AppSync::GraphQLApi" :: Text), "Properties" .= a ]
