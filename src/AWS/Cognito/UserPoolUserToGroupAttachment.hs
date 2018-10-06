{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Cognito.UserPoolUserToGroupAttachment
    ( UserPoolUserToGroupAttachment(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data UserPoolUserToGroupAttachment = UserPoolUserToGroupAttachment
    { _UserPoolUserToGroupAttachmentUserPoolId :: Text
    , _UserPoolUserToGroupAttachmentUsername :: Text
    , _UserPoolUserToGroupAttachmentGroupName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''UserPoolUserToGroupAttachment)

resourceJSON :: UserPoolUserToGroupAttachment -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Cognito::UserPoolUserToGroupAttachment" :: Text), "Properties" .= a ]
