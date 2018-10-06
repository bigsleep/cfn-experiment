{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SSM.ResourceDataSync
    ( ResourceDataSync(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ResourceDataSync = ResourceDataSync
    { _ResourceDataSyncKMSKeyArn :: Maybe Text
    , _ResourceDataSyncSyncName :: Text
    , _ResourceDataSyncBucketPrefix :: Maybe Text
    , _ResourceDataSyncBucketName :: Text
    , _ResourceDataSyncSyncFormat :: Text
    , _ResourceDataSyncBucketRegion :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''ResourceDataSync)

resourceJSON :: ResourceDataSync -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SSM::ResourceDataSync" :: Text), "Properties" .= a ]
