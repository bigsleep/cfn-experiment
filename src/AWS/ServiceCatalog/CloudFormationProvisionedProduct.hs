{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ServiceCatalog.CloudFormationProvisionedProduct
    ( ProvisioningParameter(..)
    , CloudFormationProvisionedProduct(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ProvisioningParameter = ProvisioningParameter
    { _ProvisioningParameterValue :: Maybe Text
    , _ProvisioningParameterKey :: Maybe Text
    } deriving (Show, Eq)

data CloudFormationProvisionedProduct = CloudFormationProvisionedProduct
    { _CloudFormationProvisionedProductProductName :: Maybe Text
    , _CloudFormationProvisionedProductProvisionedProductName :: Maybe Text
    , _CloudFormationProvisionedProductProvisioningArtifactId :: Maybe Text
    , _CloudFormationProvisionedProductProvisioningArtifactName :: Maybe Text
    , _CloudFormationProvisionedProductNotificationArns :: Maybe [Text]
    , _CloudFormationProvisionedProductAcceptLanguage :: Maybe Text
    , _CloudFormationProvisionedProductPathId :: Maybe Text
    , _CloudFormationProvisionedProductProvisioningParameters :: Maybe [ProvisioningParameter]
    , _CloudFormationProvisionedProductProductId :: Maybe Text
    , _CloudFormationProvisionedProductTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''ProvisioningParameter)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 33 } ''CloudFormationProvisionedProduct)

resourceJSON :: CloudFormationProvisionedProduct -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ServiceCatalog::CloudFormationProvisionedProduct" :: Text), "Properties" .= a ]
