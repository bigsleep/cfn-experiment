{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.RDS.OptionGroup
    ( OptionSetting(..)
    , OptionConfiguration(..)
    , OptionGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data OptionSetting = OptionSetting
    { _OptionSettingValue :: Maybe Text
    , _OptionSettingName :: Maybe Text
    } deriving (Show, Eq)

data OptionConfiguration = OptionConfiguration
    { _OptionConfigurationOptionName :: Text
    , _OptionConfigurationOptionSettings :: Maybe [OptionSetting]
    , _OptionConfigurationVpcSecurityGroupMemberships :: Maybe [Text]
    , _OptionConfigurationDBSecurityGroupMemberships :: Maybe [Text]
    , _OptionConfigurationOptionVersion :: Maybe Text
    , _OptionConfigurationPort :: Maybe Int
    } deriving (Show, Eq)

data OptionGroup = OptionGroup
    { _OptionGroupOptionGroupDescription :: Text
    , _OptionGroupEngineName :: Text
    , _OptionGroupMajorEngineVersion :: Text
    , _OptionGroupOptionConfigurations :: [OptionConfiguration]
    , _OptionGroupTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''OptionSetting)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''OptionConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''OptionGroup)

resourceJSON :: OptionGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::RDS::OptionGroup" :: Text), "Properties" .= a ]
