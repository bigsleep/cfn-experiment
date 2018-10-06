{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.DMS.Endpoint
    ( S3Settings(..)
    , MongoDbSettings(..)
    , DynamoDbSettings(..)
    , Endpoint(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data S3Settings = S3Settings
    { _S3SettingsCsvDelimiter :: Maybe Text
    , _S3SettingsServiceAccessRoleArn :: Maybe Text
    , _S3SettingsBucketFolder :: Maybe Text
    , _S3SettingsExternalTableDefinition :: Maybe Text
    , _S3SettingsBucketName :: Maybe Text
    , _S3SettingsCsvRowDelimiter :: Maybe Text
    , _S3SettingsCompressionType :: Maybe Text
    } deriving (Show, Eq)

data MongoDbSettings = MongoDbSettings
    { _MongoDbSettingsServerName :: Maybe Text
    , _MongoDbSettingsAuthMechanism :: Maybe Text
    , _MongoDbSettingsUsername :: Maybe Text
    , _MongoDbSettingsPassword :: Maybe Text
    , _MongoDbSettingsNestingLevel :: Maybe Text
    , _MongoDbSettingsDatabaseName :: Maybe Text
    , _MongoDbSettingsDocsToInvestigate :: Maybe Text
    , _MongoDbSettingsAuthSource :: Maybe Text
    , _MongoDbSettingsExtractDocId :: Maybe Text
    , _MongoDbSettingsAuthType :: Maybe Text
    , _MongoDbSettingsPort :: Maybe Int
    } deriving (Show, Eq)

data DynamoDbSettings = DynamoDbSettings
    { _DynamoDbSettingsServiceAccessRoleArn :: Maybe Text
    } deriving (Show, Eq)

data Endpoint = Endpoint
    { _EndpointServerName :: Maybe Text
    , _EndpointCertificateArn :: Maybe Text
    , _EndpointExtraConnectionAttributes :: Maybe Text
    , _EndpointEndpointType :: Text
    , _EndpointUsername :: Maybe Text
    , _EndpointEngineName :: Text
    , _EndpointKmsKeyId :: Maybe Text
    , _EndpointMongoDbSettings :: Maybe MongoDbSettings
    , _EndpointSslMode :: Maybe Text
    , _EndpointPassword :: Maybe Text
    , _EndpointDatabaseName :: Maybe Text
    , _EndpointS3Settings :: Maybe S3Settings
    , _EndpointEndpointIdentifier :: Maybe Text
    , _EndpointDynamoDbSettings :: Maybe DynamoDbSettings
    , _EndpointTags :: Maybe [Tag]
    , _EndpointPort :: Maybe Int
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''S3Settings)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''MongoDbSettings)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''DynamoDbSettings)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Endpoint)

resourceJSON :: Endpoint -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::DMS::Endpoint" :: Text), "Properties" .= a ]
