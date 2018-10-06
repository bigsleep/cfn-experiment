{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ElasticBeanstalk.ConfigurationTemplate
    ( SourceConfiguration(..)
    , ConfigurationOptionSetting(..)
    , ConfigurationTemplate(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SourceConfiguration = SourceConfiguration
    { _SourceConfigurationTemplateName :: Text
    , _SourceConfigurationApplicationName :: Text
    } deriving (Show, Eq)

data ConfigurationOptionSetting = ConfigurationOptionSetting
    { _ConfigurationOptionSettingOptionName :: Text
    , _ConfigurationOptionSettingResourceName :: Maybe Text
    , _ConfigurationOptionSettingNamespace :: Text
    , _ConfigurationOptionSettingValue :: Maybe Text
    } deriving (Show, Eq)

data ConfigurationTemplate = ConfigurationTemplate
    { _ConfigurationTemplateOptionSettings :: Maybe [ConfigurationOptionSetting]
    , _ConfigurationTemplatePlatformArn :: Maybe Text
    , _ConfigurationTemplateApplicationName :: Text
    , _ConfigurationTemplateSourceConfiguration :: Maybe SourceConfiguration
    , _ConfigurationTemplateSolutionStackName :: Maybe Text
    , _ConfigurationTemplateEnvironmentId :: Maybe Text
    , _ConfigurationTemplateDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''SourceConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 27 } ''ConfigurationOptionSetting)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''ConfigurationTemplate)

resourceJSON :: ConfigurationTemplate -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ElasticBeanstalk::ConfigurationTemplate" :: Text), "Properties" .= a ]
