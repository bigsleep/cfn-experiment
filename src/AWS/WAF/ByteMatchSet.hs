{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.WAF.ByteMatchSet
    ( FieldToMatch(..)
    , ByteMatchTuple(..)
    , ByteMatchSet(..)
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

data ByteMatchTuple = ByteMatchTuple
    { _ByteMatchTupleFieldToMatch :: FieldToMatch
    , _ByteMatchTupleTargetStringBase64 :: Maybe Text
    , _ByteMatchTupleTextTransformation :: Text
    , _ByteMatchTupleTargetString :: Maybe Text
    , _ByteMatchTuplePositionalConstraint :: Text
    } deriving (Show, Eq)

data ByteMatchSet = ByteMatchSet
    { _ByteMatchSetByteMatchTuples :: Maybe [ByteMatchTuple]
    , _ByteMatchSetName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''FieldToMatch)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''ByteMatchTuple)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''ByteMatchSet)

resourceJSON :: ByteMatchSet -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::WAF::ByteMatchSet" :: Text), "Properties" .= a ]
