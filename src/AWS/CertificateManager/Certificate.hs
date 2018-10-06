{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CertificateManager.Certificate
    ( DomainValidationOption(..)
    , Certificate(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data DomainValidationOption = DomainValidationOption
    { _DomainValidationOptionDomainName :: Text
    , _DomainValidationOptionValidationDomain :: Text
    } deriving (Show, Eq)

data Certificate = Certificate
    { _CertificateValidationMethod :: Maybe Text
    , _CertificateSubjectAlternativeNames :: Maybe [Text]
    , _CertificateDomainName :: Text
    , _CertificateDomainValidationOptions :: Maybe [DomainValidationOption]
    , _CertificateTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 23 } ''DomainValidationOption)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Certificate)

resourceJSON :: Certificate -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CertificateManager::Certificate" :: Text), "Properties" .= a ]
