{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SSM.Document
    ( Document(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Document = Document
    { _DocumentDocumentType :: Maybe Text
    , _DocumentContent :: DA.Value
    , _DocumentTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Document)

resourceJSON :: Document -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SSM::Document" :: Text), "Properties" .= a ]
