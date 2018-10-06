{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IoT.TopicRule
    ( LambdaAction(..)
    , KinesisAction(..)
    , S3Action(..)
    , ElasticsearchAction(..)
    , RepublishAction(..)
    , SqsAction(..)
    , CloudwatchMetricAction(..)
    , PutItemInput(..)
    , TopicRulePayload(..)
    , DynamoDBv2Action(..)
    , Action(..)
    , CloudwatchAlarmAction(..)
    , SnsAction(..)
    , DynamoDBAction(..)
    , FirehoseAction(..)
    , TopicRule(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data LambdaAction = LambdaAction
    { _LambdaActionFunctionArn :: Maybe Text
    } deriving (Show, Eq)

data KinesisAction = KinesisAction
    { _KinesisActionPartitionKey :: Maybe Text
    , _KinesisActionStreamName :: Text
    , _KinesisActionRoleArn :: Text
    } deriving (Show, Eq)

data S3Action = S3Action
    { _S3ActionBucketName :: Text
    , _S3ActionKey :: Text
    , _S3ActionRoleArn :: Text
    } deriving (Show, Eq)

data ElasticsearchAction = ElasticsearchAction
    { _ElasticsearchActionId :: Text
    , _ElasticsearchActionType :: Text
    , _ElasticsearchActionEndpoint :: Text
    , _ElasticsearchActionIndex :: Text
    , _ElasticsearchActionRoleArn :: Text
    } deriving (Show, Eq)

data RepublishAction = RepublishAction
    { _RepublishActionTopic :: Text
    , _RepublishActionRoleArn :: Text
    } deriving (Show, Eq)

data SqsAction = SqsAction
    { _SqsActionUseBase64 :: Maybe Bool
    , _SqsActionQueueUrl :: Text
    , _SqsActionRoleArn :: Text
    } deriving (Show, Eq)

data CloudwatchMetricAction = CloudwatchMetricAction
    { _CloudwatchMetricActionMetricName :: Text
    , _CloudwatchMetricActionMetricNamespace :: Text
    , _CloudwatchMetricActionMetricValue :: Text
    , _CloudwatchMetricActionMetricUnit :: Text
    , _CloudwatchMetricActionMetricTimestamp :: Maybe Text
    , _CloudwatchMetricActionRoleArn :: Text
    } deriving (Show, Eq)

data PutItemInput = PutItemInput
    { _PutItemInputTableName :: Text
    } deriving (Show, Eq)

data TopicRulePayload = TopicRulePayload
    { _TopicRulePayloadActions :: [Action]
    , _TopicRulePayloadAwsIotSqlVersion :: Maybe Text
    , _TopicRulePayloadRuleDisabled :: Bool
    , _TopicRulePayloadDescription :: Maybe Text
    , _TopicRulePayloadSql :: Text
    } deriving (Show, Eq)

data DynamoDBv2Action = DynamoDBv2Action
    { _DynamoDBv2ActionPutItem :: Maybe PutItemInput
    , _DynamoDBv2ActionRoleArn :: Maybe Text
    } deriving (Show, Eq)

data Action = Action
    { _ActionCloudwatchMetric :: Maybe CloudwatchMetricAction
    , _ActionDynamoDBv2 :: Maybe DynamoDBv2Action
    , _ActionCloudwatchAlarm :: Maybe CloudwatchAlarmAction
    , _ActionDynamoDB :: Maybe DynamoDBAction
    , _ActionSns :: Maybe SnsAction
    , _ActionFirehose :: Maybe FirehoseAction
    , _ActionLambda :: Maybe LambdaAction
    , _ActionS3 :: Maybe S3Action
    , _ActionKinesis :: Maybe KinesisAction
    , _ActionElasticsearch :: Maybe ElasticsearchAction
    , _ActionRepublish :: Maybe RepublishAction
    , _ActionSqs :: Maybe SqsAction
    } deriving (Show, Eq)

data CloudwatchAlarmAction = CloudwatchAlarmAction
    { _CloudwatchAlarmActionAlarmName :: Text
    , _CloudwatchAlarmActionStateValue :: Text
    , _CloudwatchAlarmActionStateReason :: Text
    , _CloudwatchAlarmActionRoleArn :: Text
    } deriving (Show, Eq)

data SnsAction = SnsAction
    { _SnsActionTargetArn :: Text
    , _SnsActionMessageFormat :: Maybe Text
    , _SnsActionRoleArn :: Text
    } deriving (Show, Eq)

data DynamoDBAction = DynamoDBAction
    { _DynamoDBActionHashKeyField :: Text
    , _DynamoDBActionHashKeyType :: Maybe Text
    , _DynamoDBActionRangeKeyType :: Maybe Text
    , _DynamoDBActionPayloadField :: Maybe Text
    , _DynamoDBActionRangeKeyField :: Maybe Text
    , _DynamoDBActionRangeKeyValue :: Maybe Text
    , _DynamoDBActionHashKeyValue :: Text
    , _DynamoDBActionTableName :: Text
    , _DynamoDBActionRoleArn :: Text
    } deriving (Show, Eq)

data FirehoseAction = FirehoseAction
    { _FirehoseActionSeparator :: Maybe Text
    , _FirehoseActionDeliveryStreamName :: Text
    , _FirehoseActionRoleArn :: Text
    } deriving (Show, Eq)

data TopicRule = TopicRule
    { _TopicRuleRuleName :: Maybe Text
    , _TopicRuleTopicRulePayload :: TopicRulePayload
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''LambdaAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''KinesisAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''S3Action)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''ElasticsearchAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''RepublishAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''SqsAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 23 } ''CloudwatchMetricAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''PutItemInput)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''TopicRulePayload)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''DynamoDBv2Action)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Action)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''CloudwatchAlarmAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''SnsAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''DynamoDBAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''FirehoseAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''TopicRule)

resourceJSON :: TopicRule -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IoT::TopicRule" :: Text), "Properties" .= a ]
