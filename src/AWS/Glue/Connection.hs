{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Glue.Connection
    ( ConnectionInput(..)
    , PhysicalConnectionRequirements(..)
    , Connection(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ConnectionInput = ConnectionInput
    { _ConnectionInputConnectionProperties :: DA.Value
    , _ConnectionInputMatchCriteria :: Maybe [Text]
    , _ConnectionInputPhysicalConnectionRequirements :: Maybe PhysicalConnectionRequirements
    , _ConnectionInputName :: Maybe Text
    , _ConnectionInputDescription :: Maybe Text
    , _ConnectionInputConnectionType :: Text
    } deriving (Show, Eq)

data PhysicalConnectionRequirements = PhysicalConnectionRequirements
    { _PhysicalConnectionRequirementsSecurityGroupIdList :: Maybe [Text]
    , _PhysicalConnectionRequirementsSubnetId :: Maybe Text
    , _PhysicalConnectionRequirementsAvailabilityZone :: Maybe Text
    } deriving (Show, Eq)

data Connection = Connection
    { _ConnectionConnectionInput :: ConnectionInput
    , _ConnectionCatalogId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''ConnectionInput)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 31 } ''PhysicalConnectionRequirements)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''Connection)

resourceJSON :: Connection -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Glue::Connection" :: Text), "Properties" .= a ]
