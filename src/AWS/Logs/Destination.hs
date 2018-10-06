{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Logs.Destination
    ( Destination(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Destination = Destination
    { _DestinationTargetArn :: Text
    , _DestinationDestinationPolicy :: Text
    , _DestinationDestinationName :: Text
    , _DestinationRoleArn :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Destination)

resourceJSON :: Destination -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Logs::Destination" :: Text), "Properties" .= a ]
