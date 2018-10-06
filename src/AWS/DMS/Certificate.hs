{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.DMS.Certificate
    ( Certificate(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Certificate = Certificate
    { _CertificateCertificatePem :: Maybe Text
    , _CertificateCertificateIdentifier :: Maybe Text
    , _CertificateCertificateWallet :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Certificate)

resourceJSON :: Certificate -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::DMS::Certificate" :: Text), "Properties" .= a ]
