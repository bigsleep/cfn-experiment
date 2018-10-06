{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SageMaker.EndpointConfig
    ( ProductionVariant(..)
    , EndpointConfig(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ProductionVariant = ProductionVariant
    { _ProductionVariantInitialInstanceCount :: Int
    , _ProductionVariantModelName :: Text
    , _ProductionVariantInitialVariantWeight :: Double
    , _ProductionVariantInstanceType :: Text
    , _ProductionVariantVariantName :: Text
    } deriving (Show, Eq)

data EndpointConfig = EndpointConfig
    { _EndpointConfigProductionVariants :: [ProductionVariant]
    , _EndpointConfigKmsKeyId :: Maybe Text
    , _EndpointConfigEndpointConfigName :: Maybe Text
    , _EndpointConfigTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''ProductionVariant)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''EndpointConfig)

resourceJSON :: EndpointConfig -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SageMaker::EndpointConfig" :: Text), "Properties" .= a ]
