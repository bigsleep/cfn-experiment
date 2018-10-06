{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.Method
    ( Integration(..)
    , MethodResponse(..)
    , IntegrationResponse(..)
    , Method(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Integration = Integration
    { _IntegrationRequestTemplates :: Maybe Map
    , _IntegrationCredentials :: Maybe Text
    , _IntegrationRequestParameters :: Maybe Map
    , _IntegrationConnectionId :: Maybe Text
    , _IntegrationContentHandling :: Maybe Text
    , _IntegrationPassthroughBehavior :: Maybe Text
    , _IntegrationUri :: Maybe Text
    , _IntegrationIntegrationResponses :: Maybe [IntegrationResponse]
    , _IntegrationCacheNamespace :: Maybe Text
    , _IntegrationTimeoutInMillis :: Maybe Int
    , _IntegrationType :: Maybe Text
    , _IntegrationConnectionType :: Maybe Text
    , _IntegrationIntegrationHttpMethod :: Maybe Text
    , _IntegrationCacheKeyParameters :: Maybe [Text]
    } deriving (Show, Eq)

data MethodResponse = MethodResponse
    { _MethodResponseResponseModels :: Maybe Map
    , _MethodResponseStatusCode :: Text
    , _MethodResponseResponseParameters :: Maybe Map
    } deriving (Show, Eq)

data IntegrationResponse = IntegrationResponse
    { _IntegrationResponseContentHandling :: Maybe Text
    , _IntegrationResponseSelectionPattern :: Maybe Text
    , _IntegrationResponseResponseTemplates :: Maybe Map
    , _IntegrationResponseStatusCode :: Text
    , _IntegrationResponseResponseParameters :: Maybe Map
    } deriving (Show, Eq)

data Method = Method
    { _MethodMethodResponses :: Maybe [MethodResponse]
    , _MethodHttpMethod :: Text
    , _MethodResourceId :: Text
    , _MethodAuthorizationScopes :: Maybe [Text]
    , _MethodRequestValidatorId :: Maybe Text
    , _MethodRequestModels :: Maybe Map
    , _MethodRequestParameters :: Maybe Map
    , _MethodIntegration :: Maybe Integration
    , _MethodAuthorizerId :: Maybe Text
    , _MethodOperationName :: Maybe Text
    , _MethodRestApiId :: Text
    , _MethodAuthorizationType :: Maybe Text
    , _MethodApiKeyRequired :: Maybe Bool
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Integration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''MethodResponse)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''IntegrationResponse)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Method)

resourceJSON :: Method -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::Method" :: Text), "Properties" .= a ]
