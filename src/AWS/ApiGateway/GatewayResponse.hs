{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.GatewayResponse
    ( GatewayResponse(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data GatewayResponse = GatewayResponse
    { _GatewayResponseRestApiId :: Text
    , _GatewayResponseResponseTemplates :: Maybe Map
    , _GatewayResponseResponseType :: Text
    , _GatewayResponseStatusCode :: Maybe Text
    , _GatewayResponseResponseParameters :: Maybe Map
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''GatewayResponse)

resourceJSON :: GatewayResponse -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::GatewayResponse" :: Text), "Properties" .= a ]
