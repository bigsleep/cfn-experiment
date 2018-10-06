{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Cognito.UserPoolUser
    ( AttributeType(..)
    , UserPoolUser(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data AttributeType = AttributeType
    { _AttributeTypeValue :: Maybe Text
    , _AttributeTypeName :: Maybe Text
    } deriving (Show, Eq)

data UserPoolUser = UserPoolUser
    { _UserPoolUserForceAliasCreation :: Maybe Bool
    , _UserPoolUserDesiredDeliveryMediums :: Maybe [Text]
    , _UserPoolUserMessageAction :: Maybe Text
    , _UserPoolUserUserPoolId :: Text
    , _UserPoolUserUserAttributes :: Maybe [AttributeType]
    , _UserPoolUserUsername :: Maybe Text
    , _UserPoolUserValidationData :: Maybe [AttributeType]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''AttributeType)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''UserPoolUser)

resourceJSON :: UserPoolUser -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Cognito::UserPoolUser" :: Text), "Properties" .= a ]
