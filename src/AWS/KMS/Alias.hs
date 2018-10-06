{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.KMS.Alias
    ( Alias(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Alias = Alias
    { _AliasTargetKeyId :: Text
    , _AliasAliasName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Alias)

resourceJSON :: Alias -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::KMS::Alias" :: Text), "Properties" .= a ]
