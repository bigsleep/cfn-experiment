{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CodePipeline.CustomActionType
    ( Settings(..)
    , ArtifactDetails(..)
    , ConfigurationProperties(..)
    , CustomActionType(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Settings = Settings
    { _SettingsThirdPartyConfigurationUrl :: Maybe Text
    , _SettingsExecutionUrlTemplate :: Maybe Text
    , _SettingsEntityUrlTemplate :: Maybe Text
    , _SettingsRevisionUrlTemplate :: Maybe Text
    } deriving (Show, Eq)

data ArtifactDetails = ArtifactDetails
    { _ArtifactDetailsMaximumCount :: Int
    , _ArtifactDetailsMinimumCount :: Int
    } deriving (Show, Eq)

data ConfigurationProperties = ConfigurationProperties
    { _ConfigurationPropertiesQueryable :: Maybe Bool
    , _ConfigurationPropertiesSecret :: Bool
    , _ConfigurationPropertiesRequired :: Bool
    , _ConfigurationPropertiesKey :: Bool
    , _ConfigurationPropertiesName :: Text
    , _ConfigurationPropertiesType :: Maybe Text
    , _ConfigurationPropertiesDescription :: Maybe Text
    } deriving (Show, Eq)

data CustomActionType = CustomActionType
    { _CustomActionTypeSettings :: Maybe Settings
    , _CustomActionTypeCategory :: Text
    , _CustomActionTypeOutputArtifactDetails :: ArtifactDetails
    , _CustomActionTypeConfigurationProperties :: Maybe [ConfigurationProperties]
    , _CustomActionTypeInputArtifactDetails :: ArtifactDetails
    , _CustomActionTypeVersion :: Maybe Text
    , _CustomActionTypeProvider :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Settings)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''ArtifactDetails)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''ConfigurationProperties)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''CustomActionType)

resourceJSON :: CustomActionType -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CodePipeline::CustomActionType" :: Text), "Properties" .= a ]
