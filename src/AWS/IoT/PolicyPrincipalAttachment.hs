{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IoT.PolicyPrincipalAttachment
    ( PolicyPrincipalAttachment(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data PolicyPrincipalAttachment = PolicyPrincipalAttachment
    { _PolicyPrincipalAttachmentPolicyName :: Text
    , _PolicyPrincipalAttachmentPrincipal :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''PolicyPrincipalAttachment)

resourceJSON :: PolicyPrincipalAttachment -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IoT::PolicyPrincipalAttachment" :: Text), "Properties" .= a ]
