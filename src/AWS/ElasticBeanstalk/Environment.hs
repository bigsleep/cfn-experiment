{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ElasticBeanstalk.Environment
    ( OptionSetting(..)
    , Tier(..)
    , Environment(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data OptionSetting = OptionSetting
    { _OptionSettingOptionName :: Text
    , _OptionSettingResourceName :: Maybe Text
    , _OptionSettingNamespace :: Text
    , _OptionSettingValue :: Maybe Text
    } deriving (Show, Eq)

data Tier = Tier
    { _TierName :: Maybe Text
    , _TierVersion :: Maybe Text
    , _TierType :: Maybe Text
    } deriving (Show, Eq)

data Environment = Environment
    { _EnvironmentCNAMEPrefix :: Maybe Text
    , _EnvironmentTemplateName :: Maybe Text
    , _EnvironmentOptionSettings :: Maybe [OptionSetting]
    , _EnvironmentVersionLabel :: Maybe Text
    , _EnvironmentPlatformArn :: Maybe Text
    , _EnvironmentTier :: Maybe Tier
    , _EnvironmentEnvironmentName :: Maybe Text
    , _EnvironmentApplicationName :: Text
    , _EnvironmentSolutionStackName :: Maybe Text
    , _EnvironmentDescription :: Maybe Text
    , _EnvironmentTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''OptionSetting)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 5 } ''Tier)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Environment)

resourceJSON :: Environment -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ElasticBeanstalk::Environment" :: Text), "Properties" .= a ]
