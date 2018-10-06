{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Config.ConfigRule
    ( Source(..)
    , Scope(..)
    , SourceDetail(..)
    , ConfigRule(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Source = Source
    { _SourceSourceIdentifier :: Text
    , _SourceOwner :: Text
    , _SourceSourceDetails :: Maybe [SourceDetail]
    } deriving (Show, Eq)

data Scope = Scope
    { _ScopeComplianceResourceTypes :: Maybe [Text]
    , _ScopeComplianceResourceId :: Maybe Text
    , _ScopeTagValue :: Maybe Text
    , _ScopeTagKey :: Maybe Text
    } deriving (Show, Eq)

data SourceDetail = SourceDetail
    { _SourceDetailMessageType :: Text
    , _SourceDetailMaximumExecutionFrequency :: Maybe Text
    , _SourceDetailEventSource :: Text
    } deriving (Show, Eq)

data ConfigRule = ConfigRule
    { _ConfigRuleInputParameters :: Maybe DA.Value
    , _ConfigRuleConfigRuleName :: Maybe Text
    , _ConfigRuleMaximumExecutionFrequency :: Maybe Text
    , _ConfigRuleScope :: Maybe Scope
    , _ConfigRuleSource :: Source
    , _ConfigRuleDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Source)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Scope)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''SourceDetail)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''ConfigRule)

resourceJSON :: ConfigRule -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Config::ConfigRule" :: Text), "Properties" .= a ]
