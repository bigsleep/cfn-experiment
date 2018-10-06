{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.S3.Bucket
    ( TopicConfiguration(..)
    , ServerSideEncryptionByDefault(..)
    , BucketEncryption(..)
    , QueueConfiguration(..)
    , InventoryConfiguration(..)
    , TagFilter(..)
    , LambdaConfiguration(..)
    , ServerSideEncryptionRule(..)
    , S3KeyFilter(..)
    , Transition(..)
    , MetricsConfiguration(..)
    , EncryptionConfiguration(..)
    , AccelerateConfiguration(..)
    , AccessControlTranslation(..)
    , CorsConfiguration(..)
    , StorageClassAnalysis(..)
    , AnalyticsConfiguration(..)
    , LifecycleConfiguration(..)
    , FilterRule(..)
    , NoncurrentVersionTransition(..)
    , LoggingConfiguration(..)
    , DataExport(..)
    , ReplicationConfiguration(..)
    , RedirectRule(..)
    , AbortIncompleteMultipartUpload(..)
    , RoutingRuleCondition(..)
    , RedirectAllRequestsTo(..)
    , ReplicationRule(..)
    , VersioningConfiguration(..)
    , RoutingRule(..)
    , ReplicationDestination(..)
    , SseKmsEncryptedObjects(..)
    , NotificationFilter(..)
    , NotificationConfiguration(..)
    , Rule(..)
    , SourceSelectionCriteria(..)
    , CorsRule(..)
    , WebsiteConfiguration(..)
    , Destination(..)
    , Bucket(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data TopicConfiguration = TopicConfiguration
    { _TopicConfigurationEvent :: Text
    , _TopicConfigurationTopic :: Text
    , _TopicConfigurationFilter :: Maybe NotificationFilter
    } deriving (Show, Eq)

data ServerSideEncryptionByDefault = ServerSideEncryptionByDefault
    { _ServerSideEncryptionByDefaultSSEAlgorithm :: Text
    , _ServerSideEncryptionByDefaultKMSMasterKeyID :: Maybe Text
    } deriving (Show, Eq)

data BucketEncryption = BucketEncryption
    { _BucketEncryptionServerSideEncryptionConfiguration :: [ServerSideEncryptionRule]
    } deriving (Show, Eq)

data QueueConfiguration = QueueConfiguration
    { _QueueConfigurationEvent :: Text
    , _QueueConfigurationQueue :: Text
    , _QueueConfigurationFilter :: Maybe NotificationFilter
    } deriving (Show, Eq)

data InventoryConfiguration = InventoryConfiguration
    { _InventoryConfigurationIncludedObjectVersions :: Text
    , _InventoryConfigurationDestination :: Destination
    , _InventoryConfigurationEnabled :: Bool
    , _InventoryConfigurationPrefix :: Maybe Text
    , _InventoryConfigurationOptionalFields :: Maybe [Text]
    , _InventoryConfigurationId :: Text
    , _InventoryConfigurationScheduleFrequency :: Text
    } deriving (Show, Eq)

data TagFilter = TagFilter
    { _TagFilterValue :: Text
    , _TagFilterKey :: Text
    } deriving (Show, Eq)

data LambdaConfiguration = LambdaConfiguration
    { _LambdaConfigurationEvent :: Text
    , _LambdaConfigurationFunction :: Text
    , _LambdaConfigurationFilter :: Maybe NotificationFilter
    } deriving (Show, Eq)

data ServerSideEncryptionRule = ServerSideEncryptionRule
    { _ServerSideEncryptionRuleServerSideEncryptionByDefault :: Maybe ServerSideEncryptionByDefault
    } deriving (Show, Eq)

data S3KeyFilter = S3KeyFilter
    { _S3KeyFilterRules :: [FilterRule]
    } deriving (Show, Eq)

data Transition = Transition
    { _TransitionTransitionInDays :: Maybe Int
    , _TransitionStorageClass :: Text
    , _TransitionTransitionDate :: Maybe Text
    } deriving (Show, Eq)

data MetricsConfiguration = MetricsConfiguration
    { _MetricsConfigurationPrefix :: Maybe Text
    , _MetricsConfigurationTagFilters :: Maybe [TagFilter]
    , _MetricsConfigurationId :: Text
    } deriving (Show, Eq)

data EncryptionConfiguration = EncryptionConfiguration
    { _EncryptionConfigurationReplicaKmsKeyID :: Text
    } deriving (Show, Eq)

data AccelerateConfiguration = AccelerateConfiguration
    { _AccelerateConfigurationAccelerationStatus :: Text
    } deriving (Show, Eq)

data AccessControlTranslation = AccessControlTranslation
    { _AccessControlTranslationOwner :: Text
    } deriving (Show, Eq)

data CorsConfiguration = CorsConfiguration
    { _CorsConfigurationCorsRules :: [CorsRule]
    } deriving (Show, Eq)

data StorageClassAnalysis = StorageClassAnalysis
    { _StorageClassAnalysisDataExport :: Maybe DataExport
    } deriving (Show, Eq)

data AnalyticsConfiguration = AnalyticsConfiguration
    { _AnalyticsConfigurationStorageClassAnalysis :: StorageClassAnalysis
    , _AnalyticsConfigurationPrefix :: Maybe Text
    , _AnalyticsConfigurationTagFilters :: Maybe [TagFilter]
    , _AnalyticsConfigurationId :: Text
    } deriving (Show, Eq)

data LifecycleConfiguration = LifecycleConfiguration
    { _LifecycleConfigurationRules :: [Rule]
    } deriving (Show, Eq)

data FilterRule = FilterRule
    { _FilterRuleValue :: Text
    , _FilterRuleName :: Text
    } deriving (Show, Eq)

data NoncurrentVersionTransition = NoncurrentVersionTransition
    { _NoncurrentVersionTransitionTransitionInDays :: Int
    , _NoncurrentVersionTransitionStorageClass :: Text
    } deriving (Show, Eq)

data LoggingConfiguration = LoggingConfiguration
    { _LoggingConfigurationLogFilePrefix :: Maybe Text
    , _LoggingConfigurationDestinationBucketName :: Maybe Text
    } deriving (Show, Eq)

data DataExport = DataExport
    { _DataExportOutputSchemaVersion :: Text
    , _DataExportDestination :: Destination
    } deriving (Show, Eq)

data ReplicationConfiguration = ReplicationConfiguration
    { _ReplicationConfigurationRules :: [ReplicationRule]
    , _ReplicationConfigurationRole :: Text
    } deriving (Show, Eq)

data RedirectRule = RedirectRule
    { _RedirectRuleHostName :: Maybe Text
    , _RedirectRuleProtocol :: Maybe Text
    , _RedirectRuleHttpRedirectCode :: Maybe Text
    , _RedirectRuleReplaceKeyWith :: Maybe Text
    , _RedirectRuleReplaceKeyPrefixWith :: Maybe Text
    } deriving (Show, Eq)

data AbortIncompleteMultipartUpload = AbortIncompleteMultipartUpload
    { _AbortIncompleteMultipartUploadDaysAfterInitiation :: Int
    } deriving (Show, Eq)

data RoutingRuleCondition = RoutingRuleCondition
    { _RoutingRuleConditionKeyPrefixEquals :: Maybe Text
    , _RoutingRuleConditionHttpErrorCodeReturnedEquals :: Maybe Text
    } deriving (Show, Eq)

data RedirectAllRequestsTo = RedirectAllRequestsTo
    { _RedirectAllRequestsToHostName :: Text
    , _RedirectAllRequestsToProtocol :: Maybe Text
    } deriving (Show, Eq)

data ReplicationRule = ReplicationRule
    { _ReplicationRuleStatus :: Text
    , _ReplicationRuleDestination :: ReplicationDestination
    , _ReplicationRulePrefix :: Text
    , _ReplicationRuleId :: Maybe Text
    , _ReplicationRuleSourceSelectionCriteria :: Maybe SourceSelectionCriteria
    } deriving (Show, Eq)

data VersioningConfiguration = VersioningConfiguration
    { _VersioningConfigurationStatus :: Text
    } deriving (Show, Eq)

data RoutingRule = RoutingRule
    { _RoutingRuleRedirectRule :: RedirectRule
    , _RoutingRuleRoutingRuleCondition :: Maybe RoutingRuleCondition
    } deriving (Show, Eq)

data ReplicationDestination = ReplicationDestination
    { _ReplicationDestinationAccessControlTranslation :: Maybe AccessControlTranslation
    , _ReplicationDestinationBucket :: Text
    , _ReplicationDestinationAccount :: Maybe Text
    , _ReplicationDestinationStorageClass :: Maybe Text
    , _ReplicationDestinationEncryptionConfiguration :: Maybe EncryptionConfiguration
    } deriving (Show, Eq)

data SseKmsEncryptedObjects = SseKmsEncryptedObjects
    { _SseKmsEncryptedObjectsStatus :: Text
    } deriving (Show, Eq)

data NotificationFilter = NotificationFilter
    { _NotificationFilterS3Key :: S3KeyFilter
    } deriving (Show, Eq)

data NotificationConfiguration = NotificationConfiguration
    { _NotificationConfigurationQueueConfigurations :: Maybe [QueueConfiguration]
    , _NotificationConfigurationTopicConfigurations :: Maybe [TopicConfiguration]
    , _NotificationConfigurationLambdaConfigurations :: Maybe [LambdaConfiguration]
    } deriving (Show, Eq)

data Rule = Rule
    { _RuleStatus :: Text
    , _RuleTransitions :: Maybe [Transition]
    , _RuleTransition :: Maybe Transition
    , _RulePrefix :: Maybe Text
    , _RuleNoncurrentVersionTransitions :: Maybe [NoncurrentVersionTransition]
    , _RuleNoncurrentVersionTransition :: Maybe NoncurrentVersionTransition
    , _RuleTagFilters :: Maybe [TagFilter]
    , _RuleNoncurrentVersionExpirationInDays :: Maybe Int
    , _RuleExpirationDate :: Maybe Text
    , _RuleId :: Maybe Text
    , _RuleExpirationInDays :: Maybe Int
    , _RuleAbortIncompleteMultipartUpload :: Maybe AbortIncompleteMultipartUpload
    } deriving (Show, Eq)

data SourceSelectionCriteria = SourceSelectionCriteria
    { _SourceSelectionCriteriaSseKmsEncryptedObjects :: SseKmsEncryptedObjects
    } deriving (Show, Eq)

data CorsRule = CorsRule
    { _CorsRuleAllowedMethods :: [Text]
    , _CorsRuleAllowedHeaders :: Maybe [Text]
    , _CorsRuleAllowedOrigins :: [Text]
    , _CorsRuleMaxAge :: Maybe Int
    , _CorsRuleExposedHeaders :: Maybe [Text]
    , _CorsRuleId :: Maybe Text
    } deriving (Show, Eq)

data WebsiteConfiguration = WebsiteConfiguration
    { _WebsiteConfigurationRedirectAllRequestsTo :: Maybe RedirectAllRequestsTo
    , _WebsiteConfigurationErrorDocument :: Maybe Text
    , _WebsiteConfigurationIndexDocument :: Maybe Text
    , _WebsiteConfigurationRoutingRules :: Maybe [RoutingRule]
    } deriving (Show, Eq)

data Destination = Destination
    { _DestinationBucketAccountId :: Maybe Text
    , _DestinationPrefix :: Maybe Text
    , _DestinationFormat :: Text
    , _DestinationBucketArn :: Text
    } deriving (Show, Eq)

data Bucket = Bucket
    { _BucketReplicationConfiguration :: Maybe ReplicationConfiguration
    , _BucketMetricsConfigurations :: Maybe [MetricsConfiguration]
    , _BucketVersioningConfiguration :: Maybe VersioningConfiguration
    , _BucketNotificationConfiguration :: Maybe NotificationConfiguration
    , _BucketAccessControl :: Maybe Text
    , _BucketWebsiteConfiguration :: Maybe WebsiteConfiguration
    , _BucketBucketEncryption :: Maybe BucketEncryption
    , _BucketBucketName :: Maybe Text
    , _BucketAccelerateConfiguration :: Maybe AccelerateConfiguration
    , _BucketAnalyticsConfigurations :: Maybe [AnalyticsConfiguration]
    , _BucketCorsConfiguration :: Maybe CorsConfiguration
    , _BucketLoggingConfiguration :: Maybe LoggingConfiguration
    , _BucketLifecycleConfiguration :: Maybe LifecycleConfiguration
    , _BucketInventoryConfigurations :: Maybe [InventoryConfiguration]
    , _BucketTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''TopicConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''ServerSideEncryptionByDefault)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''BucketEncryption)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''QueueConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 23 } ''InventoryConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''TagFilter)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''LambdaConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 25 } ''ServerSideEncryptionRule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''S3KeyFilter)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''Transition)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''MetricsConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''EncryptionConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''AccelerateConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 25 } ''AccessControlTranslation)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''CorsConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''StorageClassAnalysis)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 23 } ''AnalyticsConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 23 } ''LifecycleConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''FilterRule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 28 } ''NoncurrentVersionTransition)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''LoggingConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''DataExport)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 25 } ''ReplicationConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''RedirectRule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 31 } ''AbortIncompleteMultipartUpload)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''RoutingRuleCondition)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''RedirectAllRequestsTo)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''ReplicationRule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''VersioningConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''RoutingRule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 23 } ''ReplicationDestination)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 23 } ''SseKmsEncryptedObjects)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''NotificationFilter)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''NotificationConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 5 } ''Rule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''SourceSelectionCriteria)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''CorsRule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''WebsiteConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Destination)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Bucket)

resourceJSON :: Bucket -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::S3::Bucket" :: Text), "Properties" .= a ]
