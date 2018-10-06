{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EMR.SecurityConfiguration
    ( SecurityConfiguration(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SecurityConfiguration = SecurityConfiguration
    { _SecurityConfigurationSecurityConfiguration :: DA.Value
    , _SecurityConfigurationName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''SecurityConfiguration)

resourceJSON :: SecurityConfiguration -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EMR::SecurityConfiguration" :: Text), "Properties" .= a ]
