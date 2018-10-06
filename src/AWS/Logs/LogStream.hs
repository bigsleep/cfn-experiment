{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Logs.LogStream
    ( LogStream(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data LogStream = LogStream
    { _LogStreamLogGroupName :: Text
    , _LogStreamLogStreamName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''LogStream)

resourceJSON :: LogStream -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Logs::LogStream" :: Text), "Properties" .= a ]
