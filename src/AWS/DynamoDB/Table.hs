{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.DynamoDB.Table
    ( StreamSpecification(..)
    , KeySchema(..)
    , SSESpecification(..)
    , PointInTimeRecoverySpecification(..)
    , Projection(..)
    , GlobalSecondaryIndex(..)
    , LocalSecondaryIndex(..)
    , AttributeDefinition(..)
    , TimeToLiveSpecification(..)
    , ProvisionedThroughput(..)
    , Table(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data StreamSpecification = StreamSpecification
    { _StreamSpecificationStreamViewType :: Text
    } deriving (Show, Eq)

data KeySchema = KeySchema
    { _KeySchemaKeyType :: Text
    , _KeySchemaAttributeName :: Text
    } deriving (Show, Eq)

data SSESpecification = SSESpecification
    { _SSESpecificationSSEEnabled :: Bool
    } deriving (Show, Eq)

data PointInTimeRecoverySpecification = PointInTimeRecoverySpecification
    { _PointInTimeRecoverySpecificationPointInTimeRecoveryEnabled :: Maybe Bool
    } deriving (Show, Eq)

data Projection = Projection
    { _ProjectionProjectionType :: Maybe Text
    , _ProjectionNonKeyAttributes :: Maybe [Text]
    } deriving (Show, Eq)

data GlobalSecondaryIndex = GlobalSecondaryIndex
    { _GlobalSecondaryIndexProvisionedThroughput :: ProvisionedThroughput
    , _GlobalSecondaryIndexKeySchema :: [KeySchema]
    , _GlobalSecondaryIndexProjection :: Projection
    , _GlobalSecondaryIndexIndexName :: Text
    } deriving (Show, Eq)

data LocalSecondaryIndex = LocalSecondaryIndex
    { _LocalSecondaryIndexKeySchema :: [KeySchema]
    , _LocalSecondaryIndexProjection :: Projection
    , _LocalSecondaryIndexIndexName :: Text
    } deriving (Show, Eq)

data AttributeDefinition = AttributeDefinition
    { _AttributeDefinitionAttributeType :: Text
    , _AttributeDefinitionAttributeName :: Text
    } deriving (Show, Eq)

data TimeToLiveSpecification = TimeToLiveSpecification
    { _TimeToLiveSpecificationEnabled :: Bool
    , _TimeToLiveSpecificationAttributeName :: Text
    } deriving (Show, Eq)

data ProvisionedThroughput = ProvisionedThroughput
    { _ProvisionedThroughputReadCapacityUnits :: Integer
    , _ProvisionedThroughputWriteCapacityUnits :: Integer
    } deriving (Show, Eq)

data Table = Table
    { _TableAttributeDefinitions :: Maybe [AttributeDefinition]
    , _TableProvisionedThroughput :: ProvisionedThroughput
    , _TableSSESpecification :: Maybe SSESpecification
    , _TablePointInTimeRecoverySpecification :: Maybe PointInTimeRecoverySpecification
    , _TableKeySchema :: [KeySchema]
    , _TableGlobalSecondaryIndexes :: Maybe [GlobalSecondaryIndex]
    , _TableLocalSecondaryIndexes :: Maybe [LocalSecondaryIndex]
    , _TableTimeToLiveSpecification :: Maybe TimeToLiveSpecification
    , _TableTableName :: Maybe Text
    , _TableTags :: Maybe [Tag]
    , _TableStreamSpecification :: Maybe StreamSpecification
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''StreamSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''KeySchema)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''SSESpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 33 } ''PointInTimeRecoverySpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''Projection)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''GlobalSecondaryIndex)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''LocalSecondaryIndex)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''AttributeDefinition)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''TimeToLiveSpecification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''ProvisionedThroughput)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Table)

resourceJSON :: Table -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::DynamoDB::Table" :: Text), "Properties" .= a ]
