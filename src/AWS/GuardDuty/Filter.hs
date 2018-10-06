{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.GuardDuty.Filter
    ( FindingCriteria(..)
    , Condition(..)
    , Filter(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data FindingCriteria = FindingCriteria
    { _FindingCriteriaItemType :: Maybe Condition
    , _FindingCriteriaCriterion :: Maybe DA.Value
    } deriving (Show, Eq)

data Condition = Condition
    { _ConditionEq :: Maybe [Text]
    , _ConditionLte :: Maybe Int
    , _ConditionNeq :: Maybe [Text]
    , _ConditionLt :: Maybe Int
    , _ConditionGte :: Maybe Int
    } deriving (Show, Eq)

data Filter = Filter
    { _FilterFindingCriteria :: FindingCriteria
    , _FilterAction :: Text
    , _FilterDetectorId :: Text
    , _FilterName :: Maybe Text
    , _FilterDescription :: Text
    , _FilterRank :: Int
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''FindingCriteria)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Condition)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Filter)

resourceJSON :: Filter -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::GuardDuty::Filter" :: Text), "Properties" .= a ]
