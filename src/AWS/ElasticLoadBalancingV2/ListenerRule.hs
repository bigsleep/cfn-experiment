{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ElasticLoadBalancingV2.ListenerRule
    ( RuleCondition(..)
    , Action(..)
    , ListenerRule(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data RuleCondition = RuleCondition
    { _RuleConditionField :: Maybe Text
    , _RuleConditionValues :: Maybe [Text]
    } deriving (Show, Eq)

data Action = Action
    { _ActionTargetGroupArn :: Text
    , _ActionType :: Text
    } deriving (Show, Eq)

data ListenerRule = ListenerRule
    { _ListenerRulePriority :: Int
    , _ListenerRuleActions :: [Action]
    , _ListenerRuleListenerArn :: Text
    , _ListenerRuleConditions :: [RuleCondition]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''RuleCondition)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Action)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''ListenerRule)

resourceJSON :: ListenerRule -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ElasticLoadBalancingV2::ListenerRule" :: Text), "Properties" .= a ]
