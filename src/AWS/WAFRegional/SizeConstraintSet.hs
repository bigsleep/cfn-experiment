{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.WAFRegional.SizeConstraintSet
    ( SizeConstraint(..)
    , FieldToMatch(..)
    , SizeConstraintSet(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SizeConstraint = SizeConstraint
    { _SizeConstraintFieldToMatch :: FieldToMatch
    , _SizeConstraintSize :: Int
    , _SizeConstraintComparisonOperator :: Text
    , _SizeConstraintTextTransformation :: Text
    } deriving (Show, Eq)

data FieldToMatch = FieldToMatch
    { _FieldToMatchData :: Maybe Text
    , _FieldToMatchType :: Text
    } deriving (Show, Eq)

data SizeConstraintSet = SizeConstraintSet
    { _SizeConstraintSetSizeConstraints :: Maybe [SizeConstraint]
    , _SizeConstraintSetName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''SizeConstraint)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''FieldToMatch)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''SizeConstraintSet)

resourceJSON :: SizeConstraintSet -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::WAFRegional::SizeConstraintSet" :: Text), "Properties" .= a ]
