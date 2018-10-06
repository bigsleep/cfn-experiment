{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.EgressOnlyInternetGateway
    ( EgressOnlyInternetGateway(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data EgressOnlyInternetGateway = EgressOnlyInternetGateway
    { _EgressOnlyInternetGatewayVpcId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''EgressOnlyInternetGateway)

resourceJSON :: EgressOnlyInternetGateway -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::EgressOnlyInternetGateway" :: Text), "Properties" .= a ]
