{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.VPC
    ( VPC(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VPC = VPC
    { _VPCEnableDnsHostnames :: Maybe Bool
    , _VPCEnableDnsSupport :: Maybe Bool
    , _VPCCidrBlock :: Text
    , _VPCInstanceTenancy :: Maybe Text
    , _VPCTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 4 } ''VPC)

resourceJSON :: VPC -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::VPC" :: Text), "Properties" .= a ]
