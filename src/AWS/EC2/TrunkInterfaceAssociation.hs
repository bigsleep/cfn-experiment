{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.TrunkInterfaceAssociation
    ( TrunkInterfaceAssociation(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data TrunkInterfaceAssociation = TrunkInterfaceAssociation
    { _TrunkInterfaceAssociationBranchInterfaceId :: Text
    , _TrunkInterfaceAssociationGREKey :: Maybe Int
    , _TrunkInterfaceAssociationVLANId :: Maybe Int
    , _TrunkInterfaceAssociationTrunkInterfaceId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''TrunkInterfaceAssociation)

resourceJSON :: TrunkInterfaceAssociation -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::TrunkInterfaceAssociation" :: Text), "Properties" .= a ]
