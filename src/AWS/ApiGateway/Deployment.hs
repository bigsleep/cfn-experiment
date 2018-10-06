{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.Deployment
    ( AccessLogSetting(..)
    , MethodSetting(..)
    , CanarySetting(..)
    , StageDescription(..)
    , DeploymentCanarySettings(..)
    , Deployment(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data AccessLogSetting = AccessLogSetting
    { _AccessLogSettingFormat :: Maybe Text
    , _AccessLogSettingDestinationArn :: Maybe Text
    } deriving (Show, Eq)

data MethodSetting = MethodSetting
    { _MethodSettingDataTraceEnabled :: Maybe Bool
    , _MethodSettingCacheTtlInSeconds :: Maybe Int
    , _MethodSettingHttpMethod :: Maybe Text
    , _MethodSettingThrottlingBurstLimit :: Maybe Int
    , _MethodSettingCacheDataEncrypted :: Maybe Bool
    , _MethodSettingLoggingLevel :: Maybe Text
    , _MethodSettingCachingEnabled :: Maybe Bool
    , _MethodSettingResourcePath :: Maybe Text
    , _MethodSettingThrottlingRateLimit :: Maybe Double
    , _MethodSettingMetricsEnabled :: Maybe Bool
    } deriving (Show, Eq)

data CanarySetting = CanarySetting
    { _CanarySettingStageVariableOverrides :: Maybe Map
    , _CanarySettingUseStageCache :: Maybe Bool
    , _CanarySettingPercentTraffic :: Maybe Double
    } deriving (Show, Eq)

data StageDescription = StageDescription
    { _StageDescriptionDataTraceEnabled :: Maybe Bool
    , _StageDescriptionCacheTtlInSeconds :: Maybe Int
    , _StageDescriptionThrottlingBurstLimit :: Maybe Int
    , _StageDescriptionCacheDataEncrypted :: Maybe Bool
    , _StageDescriptionLoggingLevel :: Maybe Text
    , _StageDescriptionVariables :: Maybe Map
    , _StageDescriptionCanarySetting :: Maybe CanarySetting
    , _StageDescriptionDocumentationVersion :: Maybe Text
    , _StageDescriptionAccessLogSetting :: Maybe AccessLogSetting
    , _StageDescriptionClientCertificateId :: Maybe Text
    , _StageDescriptionCachingEnabled :: Maybe Bool
    , _StageDescriptionThrottlingRateLimit :: Maybe Double
    , _StageDescriptionMetricsEnabled :: Maybe Bool
    , _StageDescriptionMethodSettings :: Maybe [MethodSetting]
    , _StageDescriptionCacheClusterEnabled :: Maybe Bool
    , _StageDescriptionCacheClusterSize :: Maybe Text
    , _StageDescriptionDescription :: Maybe Text
    } deriving (Show, Eq)

data DeploymentCanarySettings = DeploymentCanarySettings
    { _DeploymentCanarySettingsStageVariableOverrides :: Maybe Map
    , _DeploymentCanarySettingsUseStageCache :: Maybe Bool
    , _DeploymentCanarySettingsPercentTraffic :: Maybe Double
    } deriving (Show, Eq)

data Deployment = Deployment
    { _DeploymentDeploymentCanarySettings :: Maybe DeploymentCanarySettings
    , _DeploymentStageDescription :: Maybe StageDescription
    , _DeploymentRestApiId :: Text
    , _DeploymentStageName :: Maybe Text
    , _DeploymentDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''AccessLogSetting)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''MethodSetting)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''CanarySetting)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''StageDescription)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 25 } ''DeploymentCanarySettings)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''Deployment)

resourceJSON :: Deployment -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::Deployment" :: Text), "Properties" .= a ]
