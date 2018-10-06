{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Glue.Partition
    ( Order(..)
    , Column(..)
    , SerdeInfo(..)
    , SkewedInfo(..)
    , StorageDescriptor(..)
    , PartitionInput(..)
    , Partition(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Order = Order
    { _OrderSortOrder :: Maybe Int
    , _OrderColumn :: Text
    } deriving (Show, Eq)

data Column = Column
    { _ColumnName :: Text
    , _ColumnType :: Maybe Text
    , _ColumnComment :: Maybe Text
    } deriving (Show, Eq)

data SerdeInfo = SerdeInfo
    { _SerdeInfoSerializationLibrary :: Maybe Text
    , _SerdeInfoName :: Maybe Text
    , _SerdeInfoParameters :: Maybe DA.Value
    } deriving (Show, Eq)

data SkewedInfo = SkewedInfo
    { _SkewedInfoSkewedColumnValueLocationMaps :: Maybe DA.Value
    , _SkewedInfoSkewedColumnValues :: Maybe [Text]
    , _SkewedInfoSkewedColumnNames :: Maybe [Text]
    } deriving (Show, Eq)

data StorageDescriptor = StorageDescriptor
    { _StorageDescriptorSortColumns :: Maybe [Order]
    , _StorageDescriptorCompressed :: Maybe Bool
    , _StorageDescriptorLocation :: Maybe Text
    , _StorageDescriptorBucketColumns :: Maybe [Text]
    , _StorageDescriptorSerdeInfo :: Maybe SerdeInfo
    , _StorageDescriptorOutputFormat :: Maybe Text
    , _StorageDescriptorNumberOfBuckets :: Maybe Int
    , _StorageDescriptorStoredAsSubDirectories :: Maybe Bool
    , _StorageDescriptorParameters :: Maybe DA.Value
    , _StorageDescriptorInputFormat :: Maybe Text
    , _StorageDescriptorSkewedInfo :: Maybe SkewedInfo
    , _StorageDescriptorColumns :: Maybe [Column]
    } deriving (Show, Eq)

data PartitionInput = PartitionInput
    { _PartitionInputValues :: [Text]
    , _PartitionInputStorageDescriptor :: Maybe StorageDescriptor
    , _PartitionInputParameters :: Maybe DA.Value
    } deriving (Show, Eq)

data Partition = Partition
    { _PartitionPartitionInput :: PartitionInput
    , _PartitionCatalogId :: Text
    , _PartitionDatabaseName :: Text
    , _PartitionTableName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Order)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Column)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''SerdeInfo)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''SkewedInfo)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''StorageDescriptor)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''PartitionInput)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Partition)

resourceJSON :: Partition -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Glue::Partition" :: Text), "Properties" .= a ]
