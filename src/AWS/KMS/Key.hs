{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.KMS.Key
    ( Key(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Key = Key
    { _KeyKeyPolicy :: DA.Value
    , _KeyEnableKeyRotation :: Maybe Bool
    , _KeyEnabled :: Maybe Bool
    , _KeyKeyUsage :: Maybe Text
    , _KeyDescription :: Maybe Text
    , _KeyTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 4 } ''Key)

resourceJSON :: Key -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::KMS::Key" :: Text), "Properties" .= a ]
