{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Athena.NamedQuery
    ( NamedQuery(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data NamedQuery = NamedQuery
    { _NamedQueryDatabase :: Text
    , _NamedQueryName :: Maybe Text
    , _NamedQueryQueryString :: Text
    , _NamedQueryDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''NamedQuery)

resourceJSON :: NamedQuery -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Athena::NamedQuery" :: Text), "Properties" .= a ]
