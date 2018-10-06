{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.CustomerGateway
    ( CustomerGateway(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data CustomerGateway = CustomerGateway
    { _CustomerGatewayIpAddress :: Text
    , _CustomerGatewayBgpAsn :: Int
    , _CustomerGatewayType :: Text
    , _CustomerGatewayTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''CustomerGateway)

resourceJSON :: CustomerGateway -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::CustomerGateway" :: Text), "Properties" .= a ]
