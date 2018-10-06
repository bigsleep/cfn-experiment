{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.S3.BucketPolicy
    ( BucketPolicy(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data BucketPolicy = BucketPolicy
    { _BucketPolicyPolicyDocument :: DA.Value
    , _BucketPolicyBucket :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''BucketPolicy)

resourceJSON :: BucketPolicy -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::S3::BucketPolicy" :: Text), "Properties" .= a ]
