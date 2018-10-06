{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.OpsWorks.UserProfile
    ( UserProfile(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data UserProfile = UserProfile
    { _UserProfileAllowSelfManagement :: Maybe Bool
    , _UserProfileSshPublicKey :: Maybe Text
    , _UserProfileSshUsername :: Maybe Text
    , _UserProfileIamUserArn :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''UserProfile)

resourceJSON :: UserProfile -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::OpsWorks::UserProfile" :: Text), "Properties" .= a ]
