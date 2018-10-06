{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EFS.FileSystem
    ( ElasticFileSystemTag(..)
    , FileSystem(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ElasticFileSystemTag = ElasticFileSystemTag
    { _ElasticFileSystemTagValue :: Text
    , _ElasticFileSystemTagKey :: Text
    } deriving (Show, Eq)

data FileSystem = FileSystem
    { _FileSystemProvisionedThroughputInMibps :: Maybe Double
    , _FileSystemPerformanceMode :: Maybe Text
    , _FileSystemEncrypted :: Maybe Bool
    , _FileSystemThroughputMode :: Maybe Text
    , _FileSystemKmsKeyId :: Maybe Text
    , _FileSystemFileSystemTags :: Maybe [ElasticFileSystemTag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''ElasticFileSystemTag)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''FileSystem)

resourceJSON :: FileSystem -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EFS::FileSystem" :: Text), "Properties" .= a ]
