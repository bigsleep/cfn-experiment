{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.RequestValidator
    ( RequestValidator(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data RequestValidator = RequestValidator
    { _RequestValidatorValidateRequestParameters :: Maybe Bool
    , _RequestValidatorValidateRequestBody :: Maybe Bool
    , _RequestValidatorName :: Maybe Text
    , _RequestValidatorRestApiId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''RequestValidator)

resourceJSON :: RequestValidator -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::RequestValidator" :: Text), "Properties" .= a ]
