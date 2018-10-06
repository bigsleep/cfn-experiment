{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.WAF.WebACL
    ( WafAction(..)
    , ActivatedRule(..)
    , WebACL(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data WafAction = WafAction
    { _WafActionType :: Text
    } deriving (Show, Eq)

data ActivatedRule = ActivatedRule
    { _ActivatedRulePriority :: Int
    , _ActivatedRuleRuleId :: Text
    , _ActivatedRuleAction :: Maybe WafAction
    } deriving (Show, Eq)

data WebACL = WebACL
    { _WebACLRules :: Maybe [ActivatedRule]
    , _WebACLMetricName :: Text
    , _WebACLName :: Text
    , _WebACLDefaultAction :: WafAction
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''WafAction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''ActivatedRule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''WebACL)

resourceJSON :: WebACL -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::WAF::WebACL" :: Text), "Properties" .= a ]
