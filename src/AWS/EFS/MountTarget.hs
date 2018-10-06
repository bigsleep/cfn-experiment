{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EFS.MountTarget
    ( MountTarget(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data MountTarget = MountTarget
    { _MountTargetIpAddress :: Maybe Text
    , _MountTargetSecurityGroups :: [Text]
    , _MountTargetFileSystemId :: Text
    , _MountTargetSubnetId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''MountTarget)

resourceJSON :: MountTarget -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EFS::MountTarget" :: Text), "Properties" .= a ]
