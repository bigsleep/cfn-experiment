{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Config.ConfigurationAggregator
    ( AccountAggregationSource(..)
    , OrganizationAggregationSource(..)
    , ConfigurationAggregator(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data AccountAggregationSource = AccountAggregationSource
    { _AccountAggregationSourceAccountIds :: [Text]
    , _AccountAggregationSourceAwsRegions :: Maybe [Text]
    , _AccountAggregationSourceAllAwsRegions :: Maybe Bool
    } deriving (Show, Eq)

data OrganizationAggregationSource = OrganizationAggregationSource
    { _OrganizationAggregationSourceAwsRegions :: Maybe [Text]
    , _OrganizationAggregationSourceAllAwsRegions :: Maybe Bool
    , _OrganizationAggregationSourceRoleArn :: Text
    } deriving (Show, Eq)

data ConfigurationAggregator = ConfigurationAggregator
    { _ConfigurationAggregatorOrganizationAggregationSource :: Maybe OrganizationAggregationSource
    , _ConfigurationAggregatorAccountAggregationSources :: Maybe [AccountAggregationSource]
    , _ConfigurationAggregatorConfigurationAggregatorName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 25 } ''AccountAggregationSource)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''OrganizationAggregationSource)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''ConfigurationAggregator)

resourceJSON :: ConfigurationAggregator -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Config::ConfigurationAggregator" :: Text), "Properties" .= a ]
