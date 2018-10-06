{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Logs.MetricFilter
    ( MetricTransformation(..)
    , MetricFilter(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data MetricTransformation = MetricTransformation
    { _MetricTransformationMetricName :: Text
    , _MetricTransformationMetricNamespace :: Text
    , _MetricTransformationMetricValue :: Text
    , _MetricTransformationDefaultValue :: Maybe Double
    } deriving (Show, Eq)

data MetricFilter = MetricFilter
    { _MetricFilterLogGroupName :: Text
    , _MetricFilterFilterPattern :: Text
    , _MetricFilterMetricTransformations :: [MetricTransformation]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''MetricTransformation)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''MetricFilter)

resourceJSON :: MetricFilter -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Logs::MetricFilter" :: Text), "Properties" .= a ]
