{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.VPCEndpointService
    ( VPCEndpointService(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VPCEndpointService = VPCEndpointService
    { _VPCEndpointServiceNetworkLoadBalancerArns :: [Text]
    , _VPCEndpointServiceAcceptanceRequired :: Maybe Bool
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''VPCEndpointService)

resourceJSON :: VPCEndpointService -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::VPCEndpointService" :: Text), "Properties" .= a ]
