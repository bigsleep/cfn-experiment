{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.VPCEndpointServicePermissions
    ( VPCEndpointServicePermissions(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VPCEndpointServicePermissions = VPCEndpointServicePermissions
    { _VPCEndpointServicePermissionsServiceId :: Text
    , _VPCEndpointServicePermissionsAllowedPrincipals :: Maybe [Text]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''VPCEndpointServicePermissions)

resourceJSON :: VPCEndpointServicePermissions -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::VPCEndpointServicePermissions" :: Text), "Properties" .= a ]
