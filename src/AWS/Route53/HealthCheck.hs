{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Route53.HealthCheck
    ( HealthCheckConfig(..)
    , HealthCheckTag(..)
    , AlarmIdentifier(..)
    , HealthCheck(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data HealthCheckConfig = HealthCheckConfig
    { _HealthCheckConfigFailureThreshold :: Maybe Int
    , _HealthCheckConfigIPAddress :: Maybe Text
    , _HealthCheckConfigEnableSNI :: Maybe Bool
    , _HealthCheckConfigSearchString :: Maybe Text
    , _HealthCheckConfigHealthThreshold :: Maybe Int
    , _HealthCheckConfigRegions :: Maybe [Text]
    , _HealthCheckConfigResourcePath :: Maybe Text
    , _HealthCheckConfigInsufficientDataHealthStatus :: Maybe Text
    , _HealthCheckConfigType :: Text
    , _HealthCheckConfigAlarmIdentifier :: Maybe AlarmIdentifier
    , _HealthCheckConfigMeasureLatency :: Maybe Bool
    , _HealthCheckConfigInverted :: Maybe Bool
    , _HealthCheckConfigFullyQualifiedDomainName :: Maybe Text
    , _HealthCheckConfigChildHealthChecks :: Maybe [Text]
    , _HealthCheckConfigRequestInterval :: Maybe Int
    , _HealthCheckConfigPort :: Maybe Int
    } deriving (Show, Eq)

data HealthCheckTag = HealthCheckTag
    { _HealthCheckTagValue :: Text
    , _HealthCheckTagKey :: Text
    } deriving (Show, Eq)

data AlarmIdentifier = AlarmIdentifier
    { _AlarmIdentifierName :: Text
    , _AlarmIdentifierRegion :: Text
    } deriving (Show, Eq)

data HealthCheck = HealthCheck
    { _HealthCheckHealthCheckConfig :: HealthCheckConfig
    , _HealthCheckHealthCheckTags :: Maybe [HealthCheckTag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''HealthCheckConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''HealthCheckTag)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''AlarmIdentifier)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''HealthCheck)

resourceJSON :: HealthCheck -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Route53::HealthCheck" :: Text), "Properties" .= a ]
