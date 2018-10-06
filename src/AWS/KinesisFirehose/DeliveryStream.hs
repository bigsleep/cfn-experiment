{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.KinesisFirehose.DeliveryStream
    ( Processor(..)
    , KMSEncryptionConfig(..)
    , BufferingHints(..)
    , EncryptionConfiguration(..)
    , SplunkRetryOptions(..)
    , CopyCommand(..)
    , S3DestinationConfiguration(..)
    , SplunkDestinationConfiguration(..)
    , ProcessingConfiguration(..)
    , ProcessorParameter(..)
    , ElasticsearchDestinationConfiguration(..)
    , RedshiftDestinationConfiguration(..)
    , KinesisStreamSourceConfiguration(..)
    , ElasticsearchRetryOptions(..)
    , ElasticsearchBufferingHints(..)
    , ExtendedS3DestinationConfiguration(..)
    , CloudWatchLoggingOptions(..)
    , DeliveryStream(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Processor = Processor
    { _ProcessorParameters :: [ProcessorParameter]
    , _ProcessorType :: Text
    } deriving (Show, Eq)

data KMSEncryptionConfig = KMSEncryptionConfig
    { _KMSEncryptionConfigAWSKMSKeyARN :: Text
    } deriving (Show, Eq)

data BufferingHints = BufferingHints
    { _BufferingHintsSizeInMBs :: Int
    , _BufferingHintsIntervalInSeconds :: Int
    } deriving (Show, Eq)

data EncryptionConfiguration = EncryptionConfiguration
    { _EncryptionConfigurationNoEncryptionConfig :: Maybe Text
    , _EncryptionConfigurationKMSEncryptionConfig :: Maybe KMSEncryptionConfig
    } deriving (Show, Eq)

data SplunkRetryOptions = SplunkRetryOptions
    { _SplunkRetryOptionsDurationInSeconds :: Int
    } deriving (Show, Eq)

data CopyCommand = CopyCommand
    { _CopyCommandCopyOptions :: Maybe Text
    , _CopyCommandDataTableColumns :: Maybe Text
    , _CopyCommandDataTableName :: Text
    } deriving (Show, Eq)

data S3DestinationConfiguration = S3DestinationConfiguration
    { _S3DestinationConfigurationPrefix :: Maybe Text
    , _S3DestinationConfigurationCloudWatchLoggingOptions :: Maybe CloudWatchLoggingOptions
    , _S3DestinationConfigurationEncryptionConfiguration :: Maybe EncryptionConfiguration
    , _S3DestinationConfigurationCompressionFormat :: Text
    , _S3DestinationConfigurationBufferingHints :: BufferingHints
    , _S3DestinationConfigurationBucketARN :: Text
    , _S3DestinationConfigurationRoleARN :: Text
    } deriving (Show, Eq)

data SplunkDestinationConfiguration = SplunkDestinationConfiguration
    { _SplunkDestinationConfigurationS3BackupMode :: Maybe Text
    , _SplunkDestinationConfigurationHECToken :: Text
    , _SplunkDestinationConfigurationHECEndpointType :: Text
    , _SplunkDestinationConfigurationS3Configuration :: S3DestinationConfiguration
    , _SplunkDestinationConfigurationCloudWatchLoggingOptions :: Maybe CloudWatchLoggingOptions
    , _SplunkDestinationConfigurationHECAcknowledgmentTimeoutInSeconds :: Maybe Int
    , _SplunkDestinationConfigurationHECEndpoint :: Text
    , _SplunkDestinationConfigurationRetryOptions :: Maybe SplunkRetryOptions
    , _SplunkDestinationConfigurationProcessingConfiguration :: Maybe ProcessingConfiguration
    } deriving (Show, Eq)

data ProcessingConfiguration = ProcessingConfiguration
    { _ProcessingConfigurationEnabled :: Maybe Bool
    , _ProcessingConfigurationProcessors :: Maybe [Processor]
    } deriving (Show, Eq)

data ProcessorParameter = ProcessorParameter
    { _ProcessorParameterParameterValue :: Text
    , _ProcessorParameterParameterName :: Text
    } deriving (Show, Eq)

data ElasticsearchDestinationConfiguration = ElasticsearchDestinationConfiguration
    { _ElasticsearchDestinationConfigurationIndexRotationPeriod :: Text
    , _ElasticsearchDestinationConfigurationTypeName :: Text
    , _ElasticsearchDestinationConfigurationS3BackupMode :: Text
    , _ElasticsearchDestinationConfigurationDomainARN :: Text
    , _ElasticsearchDestinationConfigurationS3Configuration :: S3DestinationConfiguration
    , _ElasticsearchDestinationConfigurationCloudWatchLoggingOptions :: Maybe CloudWatchLoggingOptions
    , _ElasticsearchDestinationConfigurationBufferingHints :: ElasticsearchBufferingHints
    , _ElasticsearchDestinationConfigurationRetryOptions :: ElasticsearchRetryOptions
    , _ElasticsearchDestinationConfigurationProcessingConfiguration :: Maybe ProcessingConfiguration
    , _ElasticsearchDestinationConfigurationRoleARN :: Text
    , _ElasticsearchDestinationConfigurationIndexName :: Text
    } deriving (Show, Eq)

data RedshiftDestinationConfiguration = RedshiftDestinationConfiguration
    { _RedshiftDestinationConfigurationS3Configuration :: S3DestinationConfiguration
    , _RedshiftDestinationConfigurationCloudWatchLoggingOptions :: Maybe CloudWatchLoggingOptions
    , _RedshiftDestinationConfigurationUsername :: Text
    , _RedshiftDestinationConfigurationPassword :: Text
    , _RedshiftDestinationConfigurationCopyCommand :: CopyCommand
    , _RedshiftDestinationConfigurationProcessingConfiguration :: Maybe ProcessingConfiguration
    , _RedshiftDestinationConfigurationClusterJDBCURL :: Text
    , _RedshiftDestinationConfigurationRoleARN :: Text
    } deriving (Show, Eq)

data KinesisStreamSourceConfiguration = KinesisStreamSourceConfiguration
    { _KinesisStreamSourceConfigurationKinesisStreamARN :: Text
    , _KinesisStreamSourceConfigurationRoleARN :: Text
    } deriving (Show, Eq)

data ElasticsearchRetryOptions = ElasticsearchRetryOptions
    { _ElasticsearchRetryOptionsDurationInSeconds :: Int
    } deriving (Show, Eq)

data ElasticsearchBufferingHints = ElasticsearchBufferingHints
    { _ElasticsearchBufferingHintsSizeInMBs :: Int
    , _ElasticsearchBufferingHintsIntervalInSeconds :: Int
    } deriving (Show, Eq)

data ExtendedS3DestinationConfiguration = ExtendedS3DestinationConfiguration
    { _ExtendedS3DestinationConfigurationS3BackupMode :: Maybe Text
    , _ExtendedS3DestinationConfigurationPrefix :: Text
    , _ExtendedS3DestinationConfigurationCloudWatchLoggingOptions :: Maybe CloudWatchLoggingOptions
    , _ExtendedS3DestinationConfigurationS3BackupConfiguration :: Maybe S3DestinationConfiguration
    , _ExtendedS3DestinationConfigurationEncryptionConfiguration :: Maybe EncryptionConfiguration
    , _ExtendedS3DestinationConfigurationCompressionFormat :: Text
    , _ExtendedS3DestinationConfigurationBufferingHints :: BufferingHints
    , _ExtendedS3DestinationConfigurationBucketARN :: Text
    , _ExtendedS3DestinationConfigurationProcessingConfiguration :: Maybe ProcessingConfiguration
    , _ExtendedS3DestinationConfigurationRoleARN :: Text
    } deriving (Show, Eq)

data CloudWatchLoggingOptions = CloudWatchLoggingOptions
    { _CloudWatchLoggingOptionsEnabled :: Maybe Bool
    , _CloudWatchLoggingOptionsLogGroupName :: Maybe Text
    , _CloudWatchLoggingOptionsLogStreamName :: Maybe Text
    } deriving (Show, Eq)

data DeliveryStream = DeliveryStream
    { _DeliveryStreamS3DestinationConfiguration :: Maybe S3DestinationConfiguration
    , _DeliveryStreamRedshiftDestinationConfiguration :: Maybe RedshiftDestinationConfiguration
    , _DeliveryStreamElasticsearchDestinationConfiguration :: Maybe ElasticsearchDestinationConfiguration
    , _DeliveryStreamExtendedS3DestinationConfiguration :: Maybe ExtendedS3DestinationConfiguration
    , _DeliveryStreamKinesisStreamSourceConfiguration :: Maybe KinesisStreamSourceConfiguration
    , _DeliveryStreamDeliveryStreamName :: Maybe Text
    , _DeliveryStreamDeliveryStreamType :: Maybe Text
    , _DeliveryStreamSplunkDestinationConfiguration :: Maybe SplunkDestinationConfiguration
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Processor)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''KMSEncryptionConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''BufferingHints)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''EncryptionConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''SplunkRetryOptions)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''CopyCommand)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 27 } ''S3DestinationConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 31 } ''SplunkDestinationConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''ProcessingConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''ProcessorParameter)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 38 } ''ElasticsearchDestinationConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 33 } ''RedshiftDestinationConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 33 } ''KinesisStreamSourceConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''ElasticsearchRetryOptions)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 28 } ''ElasticsearchBufferingHints)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 35 } ''ExtendedS3DestinationConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 25 } ''CloudWatchLoggingOptions)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''DeliveryStream)

resourceJSON :: DeliveryStream -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::KinesisFirehose::DeliveryStream" :: Text), "Properties" .= a ]
