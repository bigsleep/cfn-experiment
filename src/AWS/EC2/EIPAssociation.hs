{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.EIPAssociation
    ( EIPAssociation(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data EIPAssociation = EIPAssociation
    { _EIPAssociationInstanceId :: Maybe Text
    , _EIPAssociationAllocationId :: Maybe Text
    , _EIPAssociationNetworkInterfaceId :: Maybe Text
    , _EIPAssociationEIP :: Maybe Text
    , _EIPAssociationPrivateIpAddress :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''EIPAssociation)

resourceJSON :: EIPAssociation -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::EIPAssociation" :: Text), "Properties" .= a ]
