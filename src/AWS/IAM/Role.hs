{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IAM.Role
    ( Policy(..)
    , Role(..)
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

data Role = Role
    { _RoleMaxSessionDuration :: Maybe Int
    , _RoleAssumeRolePolicyDocument :: DA.Value
    , _RolePath :: Maybe Text
    , _RoleRoleName :: Maybe Text
    , _RoleManagedPolicyArns :: Maybe [Text]
    , _RolePolicies :: Maybe [Policy]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Policy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 5 } ''Role)

resourceJSON :: Role -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IAM::Role" :: Text), "Properties" .= a ]
