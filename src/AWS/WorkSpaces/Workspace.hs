{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.WorkSpaces.Workspace
    ( Workspace(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Workspace = Workspace
    { _WorkspaceDirectoryId :: Text
    , _WorkspaceUserName :: Text
    , _WorkspaceBundleId :: Text
    , _WorkspaceRootVolumeEncryptionEnabled :: Maybe Bool
    , _WorkspaceVolumeEncryptionKey :: Maybe Text
    , _WorkspaceUserVolumeEncryptionEnabled :: Maybe Bool
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Workspace)

resourceJSON :: Workspace -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::WorkSpaces::Workspace" :: Text), "Properties" .= a ]
