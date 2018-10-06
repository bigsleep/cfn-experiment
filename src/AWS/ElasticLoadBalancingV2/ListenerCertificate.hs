{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ElasticLoadBalancingV2.ListenerCertificate
    ( Certificate(..)
    , ListenerCertificate(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Certificate = Certificate
    { _CertificateCertificateArn :: Maybe Text
    } deriving (Show, Eq)

data ListenerCertificate = ListenerCertificate
    { _ListenerCertificateListenerArn :: Text
    , _ListenerCertificateCertificates :: [Certificate]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Certificate)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''ListenerCertificate)

resourceJSON :: ListenerCertificate -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ElasticLoadBalancingV2::ListenerCertificate" :: Text), "Properties" .= a ]
