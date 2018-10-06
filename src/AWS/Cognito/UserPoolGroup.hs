{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Cognito.UserPoolGroup
    ( UserPoolGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data UserPoolGroup = UserPoolGroup
    { _UserPoolGroupUserPoolId :: Text
    , _UserPoolGroupPrecedence :: Maybe Double
    , _UserPoolGroupGroupName :: Maybe Text
    , _UserPoolGroupDescription :: Maybe Text
    , _UserPoolGroupRoleArn :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''UserPoolGroup)

resourceJSON :: UserPoolGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Cognito::UserPoolGroup" :: Text), "Properties" .= a ]
