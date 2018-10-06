{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SQS.QueuePolicy
    ( QueuePolicy(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data QueuePolicy = QueuePolicy
    { _QueuePolicyPolicyDocument :: DA.Value
    , _QueuePolicyQueues :: [Text]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''QueuePolicy)

resourceJSON :: QueuePolicy -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SQS::QueuePolicy" :: Text), "Properties" .= a ]
