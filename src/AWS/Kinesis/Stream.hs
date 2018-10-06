{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Kinesis.Stream
    ( StreamEncryption(..)
    , Stream(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data StreamEncryption = StreamEncryption
    { _StreamEncryptionEncryptionType :: Text
    , _StreamEncryptionKeyId :: Text
    } deriving (Show, Eq)

data Stream = Stream
    { _StreamShardCount :: Int
    , _StreamName :: Maybe Text
    , _StreamRetentionPeriodHours :: Maybe Int
    , _StreamStreamEncryption :: Maybe StreamEncryption
    , _StreamTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''StreamEncryption)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Stream)

resourceJSON :: Stream -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Kinesis::Stream" :: Text), "Properties" .= a ]
