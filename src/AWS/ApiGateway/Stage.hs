{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.Stage
    ( CanarySetting(..)
    , MethodSetting(..)
    , AccessLogSetting(..)
    , Stage(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data CanarySetting = CanarySetting
    { _CanarySettingDeploymentId :: Maybe Text
    , _CanarySettingStageVariableOverrides :: Maybe Map
    , _CanarySettingUseStageCache :: Maybe Bool
    , _CanarySettingPercentTraffic :: Maybe Double
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

data AccessLogSetting = AccessLogSetting
    { _AccessLogSettingFormat :: Maybe Text
    , _AccessLogSettingDestinationArn :: Maybe Text
    } deriving (Show, Eq)

data Stage = Stage
    { _StageDeploymentId :: Maybe Text
    , _StageVariables :: Maybe Map
    , _StageCanarySetting :: Maybe CanarySetting
    , _StageDocumentationVersion :: Maybe Text
    , _StageAccessLogSetting :: Maybe AccessLogSetting
    , _StageClientCertificateId :: Maybe Text
    , _StageMethodSettings :: Maybe [MethodSetting]
    , _StageRestApiId :: Text
    , _StageStageName :: Maybe Text
    , _StageCacheClusterEnabled :: Maybe Bool
    , _StageCacheClusterSize :: Maybe Text
    , _StageDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''CanarySetting)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''MethodSetting)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''AccessLogSetting)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Stage)

resourceJSON :: Stage -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::Stage" :: Text), "Properties" .= a ]
