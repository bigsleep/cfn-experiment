{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ServiceCatalog.CloudFormationProduct
    ( ProvisioningArtifactProperties(..)
    , CloudFormationProduct(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ProvisioningArtifactProperties = ProvisioningArtifactProperties
    { _ProvisioningArtifactPropertiesName :: Maybe Text
    , _ProvisioningArtifactPropertiesDescription :: Maybe Text
    , _ProvisioningArtifactPropertiesInfo :: DA.Value
    } deriving (Show, Eq)

data CloudFormationProduct = CloudFormationProduct
    { _CloudFormationProductProvisioningArtifactParameters :: [ProvisioningArtifactProperties]
    , _CloudFormationProductOwner :: Text
    , _CloudFormationProductSupportUrl :: Maybe Text
    , _CloudFormationProductDistributor :: Maybe Text
    , _CloudFormationProductName :: Text
    , _CloudFormationProductAcceptLanguage :: Maybe Text
    , _CloudFormationProductSupportEmail :: Maybe Text
    , _CloudFormationProductDescription :: Maybe Text
    , _CloudFormationProductTags :: Maybe [Tag]
    , _CloudFormationProductSupportDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 31 } ''ProvisioningArtifactProperties)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''CloudFormationProduct)

resourceJSON :: CloudFormationProduct -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ServiceCatalog::CloudFormationProduct" :: Text), "Properties" .= a ]
