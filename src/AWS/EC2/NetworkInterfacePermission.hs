{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.NetworkInterfacePermission
    ( NetworkInterfacePermission(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data NetworkInterfacePermission = NetworkInterfacePermission
    { _NetworkInterfacePermissionNetworkInterfaceId :: Text
    , _NetworkInterfacePermissionAwsAccountId :: Text
    , _NetworkInterfacePermissionPermission :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 27 } ''NetworkInterfacePermission)

resourceJSON :: NetworkInterfacePermission -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::NetworkInterfacePermission" :: Text), "Properties" .= a ]
