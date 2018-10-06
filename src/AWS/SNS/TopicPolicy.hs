{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SNS.TopicPolicy
    ( TopicPolicy(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data TopicPolicy = TopicPolicy
    { _TopicPolicyPolicyDocument :: DA.Value
    , _TopicPolicyTopics :: [Text]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''TopicPolicy)

resourceJSON :: TopicPolicy -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SNS::TopicPolicy" :: Text), "Properties" .= a ]
