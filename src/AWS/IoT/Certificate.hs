{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IoT.Certificate
    ( Certificate(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Certificate = Certificate
    { _CertificateStatus :: Text
    , _CertificateCertificateSigningRequest :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Certificate)

resourceJSON :: Certificate -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IoT::Certificate" :: Text), "Properties" .= a ]
