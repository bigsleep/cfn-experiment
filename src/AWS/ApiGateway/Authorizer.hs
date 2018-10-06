{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.Authorizer
    ( Authorizer(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Authorizer = Authorizer
    { _AuthorizerIdentityValidationExpression :: Maybe Text
    , _AuthorizerAuthorizerUri :: Maybe Text
    , _AuthorizerProviderARNs :: Maybe [Text]
    , _AuthorizerName :: Maybe Text
    , _AuthorizerRestApiId :: Text
    , _AuthorizerAuthorizerResultTtlInSeconds :: Maybe Int
    , _AuthorizerType :: Maybe Text
    , _AuthorizerAuthType :: Maybe Text
    , _AuthorizerIdentitySource :: Maybe Text
    , _AuthorizerAuthorizerCredentials :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''Authorizer)

resourceJSON :: Authorizer -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::Authorizer" :: Text), "Properties" .= a ]
