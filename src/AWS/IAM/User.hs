{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IAM.User
    ( Policy(..)
    , LoginProfile(..)
    , User(..)
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

data LoginProfile = LoginProfile
    { _LoginProfilePassword :: Text
    , _LoginProfilePasswordResetRequired :: Maybe Bool
    } deriving (Show, Eq)

data User = User
    { _UserGroups :: Maybe [Text]
    , _UserPath :: Maybe Text
    , _UserLoginProfile :: Maybe LoginProfile
    , _UserUserName :: Maybe Text
    , _UserManagedPolicyArns :: Maybe [Text]
    , _UserPolicies :: Maybe [Policy]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Policy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''LoginProfile)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 5 } ''User)

resourceJSON :: User -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IAM::User" :: Text), "Properties" .= a ]
