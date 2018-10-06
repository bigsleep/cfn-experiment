{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Lambda.Version
    ( Version(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Version = Version
    { _VersionFunctionName :: Text
    , _VersionCodeSha256 :: Maybe Text
    , _VersionDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Version)

resourceJSON :: Version -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Lambda::Version" :: Text), "Properties" .= a ]
