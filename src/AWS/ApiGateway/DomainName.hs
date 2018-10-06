{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.DomainName
    ( EndpointConfiguration(..)
    , DomainName(..)
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

data DomainName = DomainName
    { _DomainNameRegionalCertificateArn :: Maybe Text
    , _DomainNameCertificateArn :: Maybe Text
    , _DomainNameDomainName :: Text
    , _DomainNameEndpointConfiguration :: Maybe EndpointConfiguration
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''EndpointConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''DomainName)

resourceJSON :: DomainName -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::DomainName" :: Text), "Properties" .= a ]
