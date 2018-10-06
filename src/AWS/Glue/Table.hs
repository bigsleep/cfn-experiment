{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Glue.Table
    ( StorageDescriptor(..)
    , SkewedInfo(..)
    , SerdeInfo(..)
    , Order(..)
    , Column(..)
    , TableInput(..)
    , Table(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

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

data SkewedInfo = SkewedInfo
    { _SkewedInfoSkewedColumnValueLocationMaps :: Maybe DA.Value
    , _SkewedInfoSkewedColumnValues :: Maybe [Text]
    , _SkewedInfoSkewedColumnNames :: Maybe [Text]
    } deriving (Show, Eq)

data SerdeInfo = SerdeInfo
    { _SerdeInfoSerializationLibrary :: Maybe Text
    , _SerdeInfoName :: Maybe Text
    , _SerdeInfoParameters :: Maybe DA.Value
    } deriving (Show, Eq)

data Order = Order
    { _OrderSortOrder :: Int
    , _OrderColumn :: Text
    } deriving (Show, Eq)

data Column = Column
    { _ColumnName :: Text
    , _ColumnType :: Maybe Text
    , _ColumnComment :: Maybe Text
    } deriving (Show, Eq)

data TableInput = TableInput
    { _TableInputRetention :: Maybe Int
    , _TableInputTableType :: Maybe Text
    , _TableInputOwner :: Maybe Text
    , _TableInputViewOriginalText :: Maybe Text
    , _TableInputViewExpandedText :: Maybe Text
    , _TableInputName :: Maybe Text
    , _TableInputStorageDescriptor :: Maybe StorageDescriptor
    , _TableInputParameters :: Maybe DA.Value
    , _TableInputDescription :: Maybe Text
    , _TableInputPartitionKeys :: Maybe [Column]
    } deriving (Show, Eq)

data Table = Table
    { _TableCatalogId :: Text
    , _TableDatabaseName :: Text
    , _TableTableInput :: TableInput
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''StorageDescriptor)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''SkewedInfo)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''SerdeInfo)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Order)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Column)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''TableInput)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Table)

resourceJSON :: Table -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Glue::Table" :: Text), "Properties" .= a ]
