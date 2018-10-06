{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ElasticLoadBalancing.LoadBalancer
    ( Listeners(..)
    , Policies(..)
    , AccessLoggingPolicy(..)
    , ConnectionDrainingPolicy(..)
    , LBCookieStickinessPolicy(..)
    , ConnectionSettings(..)
    , AppCookieStickinessPolicy(..)
    , HealthCheck(..)
    , LoadBalancer(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Listeners = Listeners
    { _ListenersPolicyNames :: Maybe [Text]
    , _ListenersInstanceProtocol :: Maybe Text
    , _ListenersInstancePort :: Text
    , _ListenersLoadBalancerPort :: Text
    , _ListenersProtocol :: Text
    , _ListenersSSLCertificateId :: Maybe Text
    } deriving (Show, Eq)

data Policies = Policies
    { _PoliciesPolicyName :: Text
    , _PoliciesLoadBalancerPorts :: Maybe [Text]
    , _PoliciesPolicyType :: Text
    , _PoliciesAttributes :: [DA.Value]
    , _PoliciesInstancePorts :: Maybe [Text]
    } deriving (Show, Eq)

data AccessLoggingPolicy = AccessLoggingPolicy
    { _AccessLoggingPolicyEmitInterval :: Maybe Int
    , _AccessLoggingPolicyEnabled :: Bool
    , _AccessLoggingPolicyS3BucketPrefix :: Maybe Text
    , _AccessLoggingPolicyS3BucketName :: Text
    } deriving (Show, Eq)

data ConnectionDrainingPolicy = ConnectionDrainingPolicy
    { _ConnectionDrainingPolicyEnabled :: Bool
    , _ConnectionDrainingPolicyTimeout :: Maybe Int
    } deriving (Show, Eq)

data LBCookieStickinessPolicy = LBCookieStickinessPolicy
    { _LBCookieStickinessPolicyPolicyName :: Maybe Text
    , _LBCookieStickinessPolicyCookieExpirationPeriod :: Maybe Text
    } deriving (Show, Eq)

data ConnectionSettings = ConnectionSettings
    { _ConnectionSettingsIdleTimeout :: Int
    } deriving (Show, Eq)

data AppCookieStickinessPolicy = AppCookieStickinessPolicy
    { _AppCookieStickinessPolicyPolicyName :: Text
    , _AppCookieStickinessPolicyCookieName :: Text
    } deriving (Show, Eq)

data HealthCheck = HealthCheck
    { _HealthCheckHealthyThreshold :: Text
    , _HealthCheckInterval :: Text
    , _HealthCheckTimeout :: Text
    , _HealthCheckUnhealthyThreshold :: Text
    , _HealthCheckTarget :: Text
    } deriving (Show, Eq)

data LoadBalancer = LoadBalancer
    { _LoadBalancerAccessLoggingPolicy :: Maybe AccessLoggingPolicy
    , _LoadBalancerSecurityGroups :: Maybe [Text]
    , _LoadBalancerHealthCheck :: Maybe HealthCheck
    , _LoadBalancerLoadBalancerName :: Maybe Text
    , _LoadBalancerSubnets :: Maybe [Text]
    , _LoadBalancerLBCookieStickinessPolicy :: Maybe [LBCookieStickinessPolicy]
    , _LoadBalancerConnectionDrainingPolicy :: Maybe ConnectionDrainingPolicy
    , _LoadBalancerAppCookieStickinessPolicy :: Maybe [AppCookieStickinessPolicy]
    , _LoadBalancerAvailabilityZones :: Maybe [Text]
    , _LoadBalancerInstances :: Maybe [Text]
    , _LoadBalancerScheme :: Maybe Text
    , _LoadBalancerListeners :: [Listeners]
    , _LoadBalancerCrossZone :: Maybe Bool
    , _LoadBalancerConnectionSettings :: Maybe ConnectionSettings
    , _LoadBalancerPolicies :: Maybe [Policies]
    , _LoadBalancerTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Listeners)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Policies)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''AccessLoggingPolicy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 25 } ''ConnectionDrainingPolicy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 25 } ''LBCookieStickinessPolicy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''ConnectionSettings)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''AppCookieStickinessPolicy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''HealthCheck)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''LoadBalancer)

resourceJSON :: LoadBalancer -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ElasticLoadBalancing::LoadBalancer" :: Text), "Properties" .= a ]
