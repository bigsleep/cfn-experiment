{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CloudFormation.Stack
    ( Stack(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Stack = Stack
    { _StackNotificationARNs :: Maybe [Text]
    , _StackParameters :: Maybe Map
    , _StackTemplateURL :: Text
    , _StackTags :: Maybe [Tag]
    , _StackTimeoutInMinutes :: Maybe Int
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Stack)

resourceJSON :: Stack -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CloudFormation::Stack" :: Text), "Properties" .= a ]
