{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.OpsWorks.App
    ( EnvironmentVariable(..)
    , DataSource(..)
    , Source(..)
    , SslConfiguration(..)
    , App(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data EnvironmentVariable = EnvironmentVariable
    { _EnvironmentVariableSecure :: Maybe Bool
    , _EnvironmentVariableValue :: Text
    , _EnvironmentVariableKey :: Text
    } deriving (Show, Eq)

data DataSource = DataSource
    { _DataSourceArn :: Maybe Text
    , _DataSourceDatabaseName :: Maybe Text
    , _DataSourceType :: Maybe Text
    } deriving (Show, Eq)

data Source = Source
    { _SourceUrl :: Maybe Text
    , _SourceUsername :: Maybe Text
    , _SourceSshKey :: Maybe Text
    , _SourcePassword :: Maybe Text
    , _SourceType :: Maybe Text
    , _SourceRevision :: Maybe Text
    } deriving (Show, Eq)

data SslConfiguration = SslConfiguration
    { _SslConfigurationPrivateKey :: Maybe Text
    , _SslConfigurationCertificate :: Maybe Text
    , _SslConfigurationChain :: Maybe Text
    } deriving (Show, Eq)

data App = App
    { _AppSslConfiguration :: Maybe SslConfiguration
    , _AppEnvironment :: Maybe [EnvironmentVariable]
    , _AppEnableSsl :: Maybe Bool
    , _AppShortname :: Maybe Text
    , _AppDataSources :: Maybe [DataSource]
    , _AppAppSource :: Maybe Source
    , _AppAttributes :: Maybe Map
    , _AppName :: Text
    , _AppType :: Text
    , _AppStackId :: Text
    , _AppDomains :: Maybe [Text]
    , _AppDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''EnvironmentVariable)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''DataSource)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Source)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''SslConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 4 } ''App)

resourceJSON :: App -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::OpsWorks::App" :: Text), "Properties" .= a ]
