{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.UsagePlan
    ( ThrottleSettings(..)
    , ApiStage(..)
    , QuotaSettings(..)
    , UsagePlan(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ThrottleSettings = ThrottleSettings
    { _ThrottleSettingsRateLimit :: Maybe Double
    , _ThrottleSettingsBurstLimit :: Maybe Int
    } deriving (Show, Eq)

data ApiStage = ApiStage
    { _ApiStageStage :: Maybe Text
    , _ApiStageApiId :: Maybe Text
    , _ApiStageThrottle :: Maybe Map
    } deriving (Show, Eq)

data QuotaSettings = QuotaSettings
    { _QuotaSettingsOffset :: Maybe Int
    , _QuotaSettingsPeriod :: Maybe Text
    , _QuotaSettingsLimit :: Maybe Int
    } deriving (Show, Eq)

data UsagePlan = UsagePlan
    { _UsagePlanApiStages :: Maybe [ApiStage]
    , _UsagePlanUsagePlanName :: Maybe Text
    , _UsagePlanThrottle :: Maybe ThrottleSettings
    , _UsagePlanDescription :: Maybe Text
    , _UsagePlanQuota :: Maybe QuotaSettings
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''ThrottleSettings)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''ApiStage)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''QuotaSettings)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''UsagePlan)

resourceJSON :: UsagePlan -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::UsagePlan" :: Text), "Properties" .= a ]
