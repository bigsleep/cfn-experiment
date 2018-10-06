{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IAM.ManagedPolicy
    ( ManagedPolicy(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ManagedPolicy = ManagedPolicy
    { _ManagedPolicyGroups :: Maybe [Text]
    , _ManagedPolicyPolicyDocument :: DA.Value
    , _ManagedPolicyRoles :: Maybe [Text]
    , _ManagedPolicyManagedPolicyName :: Maybe Text
    , _ManagedPolicyUsers :: Maybe [Text]
    , _ManagedPolicyPath :: Maybe Text
    , _ManagedPolicyDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''ManagedPolicy)

resourceJSON :: ManagedPolicy -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IAM::ManagedPolicy" :: Text), "Properties" .= a ]
