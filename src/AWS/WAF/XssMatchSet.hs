{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.WAF.XssMatchSet
    ( FieldToMatch(..)
    , XssMatchTuple(..)
    , XssMatchSet(..)
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

data XssMatchTuple = XssMatchTuple
    { _XssMatchTupleFieldToMatch :: FieldToMatch
    , _XssMatchTupleTextTransformation :: Text
    } deriving (Show, Eq)

data XssMatchSet = XssMatchSet
    { _XssMatchSetXssMatchTuples :: [XssMatchTuple]
    , _XssMatchSetName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''FieldToMatch)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''XssMatchTuple)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''XssMatchSet)

resourceJSON :: XssMatchSet -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::WAF::XssMatchSet" :: Text), "Properties" .= a ]
