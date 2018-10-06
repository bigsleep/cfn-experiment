{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CloudWatch.Alarm
    ( Dimension(..)
    , Alarm(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Dimension = Dimension
    { _DimensionValue :: Text
    , _DimensionName :: Text
    } deriving (Show, Eq)

data Alarm = Alarm
    { _AlarmAlarmName :: Maybe Text
    , _AlarmTreatMissingData :: Maybe Text
    , _AlarmPeriod :: Int
    , _AlarmAlarmDescription :: Maybe Text
    , _AlarmEvaluationPeriods :: Int
    , _AlarmMetricName :: Text
    , _AlarmNamespace :: Text
    , _AlarmComparisonOperator :: Text
    , _AlarmOKActions :: Maybe [Text]
    , _AlarmEvaluateLowSampleCountPercentile :: Maybe Text
    , _AlarmThreshold :: Double
    , _AlarmActionsEnabled :: Maybe Bool
    , _AlarmInsufficientDataActions :: Maybe [Text]
    , _AlarmDimensions :: Maybe [Dimension]
    , _AlarmAlarmActions :: Maybe [Text]
    , _AlarmUnit :: Maybe Text
    , _AlarmStatistic :: Maybe Text
    , _AlarmExtendedStatistic :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Dimension)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Alarm)

resourceJSON :: Alarm -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CloudWatch::Alarm" :: Text), "Properties" .= a ]
