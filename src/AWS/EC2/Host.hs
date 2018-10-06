{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.Host
    ( Host(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Host = Host
    { _HostInstanceType :: Text
    , _HostAvailabilityZone :: Text
    , _HostAutoPlacement :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 5 } ''Host)

resourceJSON :: Host -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::Host" :: Text), "Properties" .= a ]
