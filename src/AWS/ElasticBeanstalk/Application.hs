{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ElasticBeanstalk.Application
    ( MaxCountRule(..)
    , MaxAgeRule(..)
    , ApplicationVersionLifecycleConfig(..)
    , ApplicationResourceLifecycleConfig(..)
    , Application(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data MaxCountRule = MaxCountRule
    { _MaxCountRuleMaxCount :: Maybe Int
    , _MaxCountRuleDeleteSourceFromS3 :: Maybe Bool
    , _MaxCountRuleEnabled :: Maybe Bool
    } deriving (Show, Eq)

data MaxAgeRule = MaxAgeRule
    { _MaxAgeRuleDeleteSourceFromS3 :: Maybe Bool
    , _MaxAgeRuleEnabled :: Maybe Bool
    , _MaxAgeRuleMaxAgeInDays :: Maybe Int
    } deriving (Show, Eq)

data ApplicationVersionLifecycleConfig = ApplicationVersionLifecycleConfig
    { _ApplicationVersionLifecycleConfigMaxAgeRule :: Maybe MaxAgeRule
    , _ApplicationVersionLifecycleConfigMaxCountRule :: Maybe MaxCountRule
    } deriving (Show, Eq)

data ApplicationResourceLifecycleConfig = ApplicationResourceLifecycleConfig
    { _ApplicationResourceLifecycleConfigVersionLifecycleConfig :: Maybe ApplicationVersionLifecycleConfig
    , _ApplicationResourceLifecycleConfigServiceRole :: Maybe Text
    } deriving (Show, Eq)

data Application = Application
    { _ApplicationApplicationName :: Maybe Text
    , _ApplicationResourceLifecycleConfig :: Maybe ApplicationResourceLifecycleConfig
    , _ApplicationDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''MaxCountRule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''MaxAgeRule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 34 } ''ApplicationVersionLifecycleConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 35 } ''ApplicationResourceLifecycleConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Application)

resourceJSON :: Application -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ElasticBeanstalk::Application" :: Text), "Properties" .= a ]
