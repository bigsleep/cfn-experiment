{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CodeDeploy.Application
    ( Application(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Application = Application
    { _ApplicationComputePlatform :: Maybe Text
    , _ApplicationApplicationName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Application)

resourceJSON :: Application -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CodeDeploy::Application" :: Text), "Properties" .= a ]
