{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.WAF.SqlInjectionMatchSet
    ( FieldToMatch(..)
    , SqlInjectionMatchTuple(..)
    , SqlInjectionMatchSet(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data FieldToMatch = FieldToMatch
    { _FieldToMatchData :: Maybe Text
    , _FieldToMatchType :: Text
    } deriving (Show, Eq)

data SqlInjectionMatchTuple = SqlInjectionMatchTuple
    { _SqlInjectionMatchTupleFieldToMatch :: FieldToMatch
    , _SqlInjectionMatchTupleTextTransformation :: Text
    } deriving (Show, Eq)

data SqlInjectionMatchSet = SqlInjectionMatchSet
    { _SqlInjectionMatchSetName :: Text
    , _SqlInjectionMatchSetSqlInjectionMatchTuples :: Maybe [SqlInjectionMatchTuple]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''FieldToMatch)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 23 } ''SqlInjectionMatchTuple)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''SqlInjectionMatchSet)

resourceJSON :: SqlInjectionMatchSet -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::WAF::SqlInjectionMatchSet" :: Text), "Properties" .= a ]
