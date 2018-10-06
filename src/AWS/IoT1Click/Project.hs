{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IoT1Click.Project
    ( PlacementTemplate(..)
    , DeviceTemplate(..)
    , Project(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data PlacementTemplate = PlacementTemplate
    { _PlacementTemplateDeviceTemplates :: Maybe DA.Value
    , _PlacementTemplateDefaultAttributes :: Maybe DA.Value
    } deriving (Show, Eq)

data DeviceTemplate = DeviceTemplate
    { _DeviceTemplateDeviceType :: Maybe Text
    , _DeviceTemplateCallbackOverrides :: Maybe DA.Value
    } deriving (Show, Eq)

data Project = Project
    { _ProjectPlacementTemplate :: PlacementTemplate
    , _ProjectProjectName :: Text
    , _ProjectDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''PlacementTemplate)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''DeviceTemplate)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Project)

resourceJSON :: Project -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IoT1Click::Project" :: Text), "Properties" .= a ]
