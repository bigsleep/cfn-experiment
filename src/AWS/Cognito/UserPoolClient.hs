{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Cognito.UserPoolClient
    ( UserPoolClient(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data UserPoolClient = UserPoolClient
    { _UserPoolClientRefreshTokenValidity :: Maybe Double
    , _UserPoolClientExplicitAuthFlows :: Maybe [Text]
    , _UserPoolClientGenerateSecret :: Maybe Bool
    , _UserPoolClientUserPoolId :: Text
    , _UserPoolClientWriteAttributes :: Maybe [Text]
    , _UserPoolClientReadAttributes :: Maybe [Text]
    , _UserPoolClientClientName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''UserPoolClient)

resourceJSON :: UserPoolClient -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Cognito::UserPoolClient" :: Text), "Properties" .= a ]
