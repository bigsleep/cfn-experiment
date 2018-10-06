{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Glue.Database
    ( DatabaseInput(..)
    , Database(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data DatabaseInput = DatabaseInput
    { _DatabaseInputLocationUri :: Maybe Text
    , _DatabaseInputName :: Maybe Text
    , _DatabaseInputParameters :: Maybe DA.Value
    , _DatabaseInputDescription :: Maybe Text
    } deriving (Show, Eq)

data Database = Database
    { _DatabaseDatabaseInput :: DatabaseInput
    , _DatabaseCatalogId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''DatabaseInput)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Database)

resourceJSON :: Database -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Glue::Database" :: Text), "Properties" .= a ]
