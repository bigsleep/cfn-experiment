{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ServiceCatalog.TagOption
    ( TagOption(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data TagOption = TagOption
    { _TagOptionValue :: Text
    , _TagOptionActive :: Maybe Bool
    , _TagOptionKey :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''TagOption)

resourceJSON :: TagOption -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ServiceCatalog::TagOption" :: Text), "Properties" .= a ]
