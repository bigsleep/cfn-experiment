{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.GameLift.Fleet
    ( IpPermission(..)
    , Fleet(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data IpPermission = IpPermission
    { _IpPermissionFromPort :: Int
    , _IpPermissionProtocol :: Text
    , _IpPermissionToPort :: Int
    , _IpPermissionIpRange :: Text
    } deriving (Show, Eq)

data Fleet = Fleet
    { _FleetServerLaunchParameters :: Maybe Text
    , _FleetLogPaths :: Maybe [Text]
    , _FleetEC2InstanceType :: Text
    , _FleetBuildId :: Text
    , _FleetDesiredEC2Instances :: Int
    , _FleetEC2InboundPermissions :: Maybe [IpPermission]
    , _FleetMaxSize :: Maybe Int
    , _FleetName :: Text
    , _FleetMinSize :: Maybe Int
    , _FleetServerLaunchPath :: Text
    , _FleetDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''IpPermission)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Fleet)

resourceJSON :: Fleet -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::GameLift::Fleet" :: Text), "Properties" .= a ]
