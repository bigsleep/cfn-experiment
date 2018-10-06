{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.WAFRegional.WebACL
    ( Rule(..)
    , Action(..)
    , WebACL(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Rule = Rule
    { _RulePriority :: Int
    , _RuleRuleId :: Text
    , _RuleAction :: Action
    } deriving (Show, Eq)

data Action = Action
    { _ActionType :: Text
    } deriving (Show, Eq)

data WebACL = WebACL
    { _WebACLRules :: Maybe [Rule]
    , _WebACLMetricName :: Text
    , _WebACLName :: Text
    , _WebACLDefaultAction :: Action
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 5 } ''Rule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Action)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''WebACL)

resourceJSON :: WebACL -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::WAFRegional::WebACL" :: Text), "Properties" .= a ]
