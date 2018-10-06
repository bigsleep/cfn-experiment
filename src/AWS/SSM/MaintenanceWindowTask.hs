{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SSM.MaintenanceWindowTask
    ( MaintenanceWindowRunCommandParameters(..)
    , MaintenanceWindowStepFunctionsParameters(..)
    , NotificationConfig(..)
    , MaintenanceWindowAutomationParameters(..)
    , LoggingInfo(..)
    , TaskInvocationParameters(..)
    , Target(..)
    , MaintenanceWindowLambdaParameters(..)
    , MaintenanceWindowTask(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data MaintenanceWindowRunCommandParameters = MaintenanceWindowRunCommandParameters
    { _MaintenanceWindowRunCommandParametersServiceRoleArn :: Maybe Text
    , _MaintenanceWindowRunCommandParametersNotificationConfig :: Maybe NotificationConfig
    , _MaintenanceWindowRunCommandParametersDocumentHashType :: Maybe Text
    , _MaintenanceWindowRunCommandParametersOutputS3KeyPrefix :: Maybe Text
    , _MaintenanceWindowRunCommandParametersParameters :: Maybe DA.Value
    , _MaintenanceWindowRunCommandParametersDocumentHash :: Maybe Text
    , _MaintenanceWindowRunCommandParametersTimeoutSeconds :: Maybe Int
    , _MaintenanceWindowRunCommandParametersComment :: Maybe Text
    , _MaintenanceWindowRunCommandParametersOutputS3BucketName :: Maybe Text
    } deriving (Show, Eq)

data MaintenanceWindowStepFunctionsParameters = MaintenanceWindowStepFunctionsParameters
    { _MaintenanceWindowStepFunctionsParametersInput :: Maybe Text
    , _MaintenanceWindowStepFunctionsParametersName :: Maybe Text
    } deriving (Show, Eq)

data NotificationConfig = NotificationConfig
    { _NotificationConfigNotificationEvents :: Maybe [Text]
    , _NotificationConfigNotificationType :: Maybe Text
    , _NotificationConfigNotificationArn :: Text
    } deriving (Show, Eq)

data MaintenanceWindowAutomationParameters = MaintenanceWindowAutomationParameters
    { _MaintenanceWindowAutomationParametersParameters :: Maybe DA.Value
    , _MaintenanceWindowAutomationParametersDocumentVersion :: Maybe Text
    } deriving (Show, Eq)

data LoggingInfo = LoggingInfo
    { _LoggingInfoRegion :: Text
    , _LoggingInfoS3Prefix :: Maybe Text
    , _LoggingInfoS3Bucket :: Text
    } deriving (Show, Eq)

data TaskInvocationParameters = TaskInvocationParameters
    { _TaskInvocationParametersMaintenanceWindowLambdaParameters :: Maybe MaintenanceWindowLambdaParameters
    , _TaskInvocationParametersMaintenanceWindowRunCommandParameters :: Maybe MaintenanceWindowRunCommandParameters
    , _TaskInvocationParametersMaintenanceWindowStepFunctionsParameters :: Maybe MaintenanceWindowStepFunctionsParameters
    , _TaskInvocationParametersMaintenanceWindowAutomationParameters :: Maybe MaintenanceWindowAutomationParameters
    } deriving (Show, Eq)

data Target = Target
    { _TargetValues :: Maybe [Text]
    , _TargetKey :: Text
    } deriving (Show, Eq)

data MaintenanceWindowLambdaParameters = MaintenanceWindowLambdaParameters
    { _MaintenanceWindowLambdaParametersPayload :: Maybe Text
    , _MaintenanceWindowLambdaParametersQualifier :: Maybe Text
    , _MaintenanceWindowLambdaParametersClientContext :: Maybe Text
    } deriving (Show, Eq)

data MaintenanceWindowTask = MaintenanceWindowTask
    { _MaintenanceWindowTaskServiceRoleArn :: Text
    , _MaintenanceWindowTaskTaskParameters :: Maybe DA.Value
    , _MaintenanceWindowTaskPriority :: Int
    , _MaintenanceWindowTaskTaskType :: Text
    , _MaintenanceWindowTaskTaskArn :: Text
    , _MaintenanceWindowTaskMaxErrors :: Text
    , _MaintenanceWindowTaskTaskInvocationParameters :: Maybe TaskInvocationParameters
    , _MaintenanceWindowTaskName :: Maybe Text
    , _MaintenanceWindowTaskTargets :: [Target]
    , _MaintenanceWindowTaskLoggingInfo :: Maybe LoggingInfo
    , _MaintenanceWindowTaskDescription :: Maybe Text
    , _MaintenanceWindowTaskMaxConcurrency :: Text
    , _MaintenanceWindowTaskWindowId :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 38 } ''MaintenanceWindowRunCommandParameters)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 41 } ''MaintenanceWindowStepFunctionsParameters)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''NotificationConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 38 } ''MaintenanceWindowAutomationParameters)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''LoggingInfo)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 25 } ''TaskInvocationParameters)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Target)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 34 } ''MaintenanceWindowLambdaParameters)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''MaintenanceWindowTask)

resourceJSON :: MaintenanceWindowTask -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SSM::MaintenanceWindowTask" :: Text), "Properties" .= a ]
