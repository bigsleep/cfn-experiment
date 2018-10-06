{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Inspector.ResourceGroup
    ( ResourceGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ResourceGroup = ResourceGroup
    { _ResourceGroupResourceGroupTags :: [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''ResourceGroup)

resourceJSON :: ResourceGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Inspector::ResourceGroup" :: Text), "Properties" .= a ]
