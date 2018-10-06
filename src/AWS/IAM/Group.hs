{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IAM.Group
    ( Policy(..)
    , Group(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Policy = Policy
    { _PolicyPolicyDocument :: DA.Value
    , _PolicyPolicyName :: Text
    } deriving (Show, Eq)

data Group = Group
    { _GroupPath :: Maybe Text
    , _GroupGroupName :: Maybe Text
    , _GroupManagedPolicyArns :: Maybe [Text]
    , _GroupPolicies :: Maybe [Policy]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Policy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Group)

resourceJSON :: Group -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IAM::Group" :: Text), "Properties" .= a ]
