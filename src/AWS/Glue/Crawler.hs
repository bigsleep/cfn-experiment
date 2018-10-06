{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Glue.Crawler
    ( JdbcTarget(..)
    , S3Target(..)
    , SchemaChangePolicy(..)
    , Targets(..)
    , Schedule(..)
    , Crawler(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data JdbcTarget = JdbcTarget
    { _JdbcTargetPath :: Maybe Text
    , _JdbcTargetConnectionName :: Maybe Text
    , _JdbcTargetExclusions :: Maybe [Text]
    } deriving (Show, Eq)

data S3Target = S3Target
    { _S3TargetPath :: Maybe Text
    , _S3TargetExclusions :: Maybe [Text]
    } deriving (Show, Eq)

data SchemaChangePolicy = SchemaChangePolicy
    { _SchemaChangePolicyDeleteBehavior :: Maybe Text
    , _SchemaChangePolicyUpdateBehavior :: Maybe Text
    } deriving (Show, Eq)

data Targets = Targets
    { _TargetsS3Targets :: Maybe [S3Target]
    , _TargetsJdbcTargets :: Maybe [JdbcTarget]
    } deriving (Show, Eq)

data Schedule = Schedule
    { _ScheduleScheduleExpression :: Maybe Text
    } deriving (Show, Eq)

data Crawler = Crawler
    { _CrawlerSchemaChangePolicy :: Maybe SchemaChangePolicy
    , _CrawlerSchedule :: Maybe Schedule
    , _CrawlerClassifiers :: Maybe [Text]
    , _CrawlerRole :: Text
    , _CrawlerName :: Maybe Text
    , _CrawlerTargets :: Targets
    , _CrawlerDatabaseName :: Text
    , _CrawlerConfiguration :: Maybe Text
    , _CrawlerTablePrefix :: Maybe Text
    , _CrawlerDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''JdbcTarget)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''S3Target)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''SchemaChangePolicy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Targets)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Schedule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Crawler)

resourceJSON :: Crawler -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Glue::Crawler" :: Text), "Properties" .= a ]
