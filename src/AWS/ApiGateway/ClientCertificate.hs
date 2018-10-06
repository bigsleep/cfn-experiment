{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.ClientCertificate
    ( ClientCertificate(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ClientCertificate = ClientCertificate
    { _ClientCertificateDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''ClientCertificate)

resourceJSON :: ClientCertificate -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::ClientCertificate" :: Text), "Properties" .= a ]
