{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Glue.Trigger
    ( Action(..)
    , Predicate(..)
    , Condition(..)
    , Trigger(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Action = Action
    { _ActionArguments :: Maybe DA.Value
    , _ActionJobName :: Maybe Text
    } deriving (Show, Eq)

data Predicate = Predicate
    { _PredicateLogical :: Maybe Text
    , _PredicateConditions :: Maybe [Condition]
    } deriving (Show, Eq)

data Condition = Condition
    { _ConditionState :: Maybe Text
    , _ConditionJobName :: Maybe Text
    , _ConditionLogicalOperator :: Maybe Text
    } deriving (Show, Eq)

data Trigger = Trigger
    { _TriggerActions :: [Action]
    , _TriggerSchedule :: Maybe Text
    , _TriggerPredicate :: Maybe Predicate
    , _TriggerName :: Maybe Text
    , _TriggerType :: Text
    , _TriggerDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Action)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Predicate)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Condition)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Trigger)

resourceJSON :: Trigger -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Glue::Trigger" :: Text), "Properties" .= a ]
