{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Lambda.EventSourceMapping
    ( EventSourceMapping(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data EventSourceMapping = EventSourceMapping
    { _EventSourceMappingEventSourceArn :: Text
    , _EventSourceMappingEnabled :: Maybe Bool
    , _EventSourceMappingBatchSize :: Maybe Int
    , _EventSourceMappingFunctionName :: Text
    , _EventSourceMappingStartingPosition :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''EventSourceMapping)

resourceJSON :: EventSourceMapping -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Lambda::EventSourceMapping" :: Text), "Properties" .= a ]
