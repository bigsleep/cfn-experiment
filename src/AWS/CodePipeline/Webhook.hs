{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CodePipeline.Webhook
    ( WebhookAuthConfiguration(..)
    , WebhookFilterRule(..)
    , Webhook(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data WebhookAuthConfiguration = WebhookAuthConfiguration
    { _WebhookAuthConfigurationAllowedIPRange :: Maybe Text
    , _WebhookAuthConfigurationSecretToken :: Maybe Text
    } deriving (Show, Eq)

data WebhookFilterRule = WebhookFilterRule
    { _WebhookFilterRuleMatchEquals :: Maybe Text
    , _WebhookFilterRuleJsonPath :: Text
    } deriving (Show, Eq)

data Webhook = Webhook
    { _WebhookTargetAction :: Text
    , _WebhookAuthentication :: Text
    , _WebhookFilters :: [WebhookFilterRule]
    , _WebhookTargetPipeline :: Text
    , _WebhookTargetPipelineVersion :: Int
    , _WebhookName :: Maybe Text
    , _WebhookAuthenticationConfiguration :: WebhookAuthConfiguration
    , _WebhookRegisterWithThirdParty :: Maybe Bool
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 25 } ''WebhookAuthConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''WebhookFilterRule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Webhook)

resourceJSON :: Webhook -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CodePipeline::Webhook" :: Text), "Properties" .= a ]
