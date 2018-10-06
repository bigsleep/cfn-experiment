{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.Volume
    ( Volume(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Volume = Volume
    { _VolumeSize :: Maybe Int
    , _VolumeIops :: Maybe Int
    , _VolumeEncrypted :: Maybe Bool
    , _VolumeKmsKeyId :: Maybe Text
    , _VolumeAvailabilityZone :: Text
    , _VolumeAutoEnableIO :: Maybe Bool
    , _VolumeVolumeType :: Maybe Text
    , _VolumeTags :: Maybe [Tag]
    , _VolumeSnapshotId :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Volume)

resourceJSON :: Volume -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::Volume" :: Text), "Properties" .= a ]
