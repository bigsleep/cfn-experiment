{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.RestApi
    ( EndpointConfiguration(..)
    , S3Location(..)
    , RestApi(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data EndpointConfiguration = EndpointConfiguration
    { _EndpointConfigurationTypes :: Maybe [Text]
    } deriving (Show, Eq)

data S3Location = S3Location
    { _S3LocationETag :: Maybe Text
    , _S3LocationBucket :: Maybe Text
    , _S3LocationKey :: Maybe Text
    , _S3LocationVersion :: Maybe Text
    } deriving (Show, Eq)

data RestApi = RestApi
    { _RestApiApiKeySourceType :: Maybe Text
    , _RestApiMinimumCompressionSize :: Maybe Int
    , _RestApiBody :: Maybe DA.Value
    , _RestApiBinaryMediaTypes :: Maybe [Text]
    , _RestApiName :: Maybe Text
    , _RestApiFailOnWarnings :: Maybe Bool
    , _RestApiParameters :: Maybe Map
    , _RestApiBodyS3Location :: Maybe S3Location
    , _RestApiCloneFrom :: Maybe Text
    , _RestApiPolicy :: Maybe DA.Value
    , _RestApiEndpointConfiguration :: Maybe EndpointConfiguration
    , _RestApiDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''EndpointConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''S3Location)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''RestApi)

resourceJSON :: RestApi -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::RestApi" :: Text), "Properties" .= a ]
