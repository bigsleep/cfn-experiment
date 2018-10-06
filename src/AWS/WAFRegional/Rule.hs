{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.WAFRegional.Rule
    ( Predicate(..)
    , Rule(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Predicate = Predicate
    { _PredicateNegated :: Bool
    , _PredicateDataId :: Text
    , _PredicateType :: Text
    } deriving (Show, Eq)

data Rule = Rule
    { _RulePredicates :: Maybe [Predicate]
    , _RuleMetricName :: Text
    , _RuleName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Predicate)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 5 } ''Rule)

resourceJSON :: Rule -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::WAFRegional::Rule" :: Text), "Properties" .= a ]
