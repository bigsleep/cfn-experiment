{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ServiceCatalog.TagOptionAssociation
    ( TagOptionAssociation(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data TagOptionAssociation = TagOptionAssociation
    { _TagOptionAssociationTagOptionId :: Text
    , _TagOptionAssociationResourceId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''TagOptionAssociation)

resourceJSON :: TagOptionAssociation -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ServiceCatalog::TagOptionAssociation" :: Text), "Properties" .= a ]
