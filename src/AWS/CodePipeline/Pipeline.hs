{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CodePipeline.Pipeline
    ( ArtifactStore(..)
    , OutputArtifact(..)
    , StageDeclaration(..)
    , StageTransition(..)
    , EncryptionKey(..)
    , ActionTypeId(..)
    , BlockerDeclaration(..)
    , ActionDeclaration(..)
    , InputArtifact(..)
    , Pipeline(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ArtifactStore = ArtifactStore
    { _ArtifactStoreLocation :: Text
    , _ArtifactStoreEncryptionKey :: Maybe EncryptionKey
    , _ArtifactStoreType :: Text
    } deriving (Show, Eq)

data OutputArtifact = OutputArtifact
    { _OutputArtifactName :: Text
    } deriving (Show, Eq)

data StageDeclaration = StageDeclaration
    { _StageDeclarationActions :: [ActionDeclaration]
    , _StageDeclarationBlockers :: Maybe [BlockerDeclaration]
    , _StageDeclarationName :: Text
    } deriving (Show, Eq)

data StageTransition = StageTransition
    { _StageTransitionReason :: Text
    , _StageTransitionStageName :: Text
    } deriving (Show, Eq)

data EncryptionKey = EncryptionKey
    { _EncryptionKeyId :: Text
    , _EncryptionKeyType :: Text
    } deriving (Show, Eq)

data ActionTypeId = ActionTypeId
    { _ActionTypeIdCategory :: Text
    , _ActionTypeIdOwner :: Text
    , _ActionTypeIdVersion :: Text
    , _ActionTypeIdProvider :: Text
    } deriving (Show, Eq)

data BlockerDeclaration = BlockerDeclaration
    { _BlockerDeclarationName :: Text
    , _BlockerDeclarationType :: Text
    } deriving (Show, Eq)

data ActionDeclaration = ActionDeclaration
    { _ActionDeclarationOutputArtifacts :: Maybe [OutputArtifact]
    , _ActionDeclarationName :: Text
    , _ActionDeclarationRunOrder :: Maybe Int
    , _ActionDeclarationConfiguration :: Maybe DA.Value
    , _ActionDeclarationActionTypeId :: ActionTypeId
    , _ActionDeclarationInputArtifacts :: Maybe [InputArtifact]
    , _ActionDeclarationRoleArn :: Maybe Text
    } deriving (Show, Eq)

data InputArtifact = InputArtifact
    { _InputArtifactName :: Text
    } deriving (Show, Eq)

data Pipeline = Pipeline
    { _PipelineArtifactStore :: ArtifactStore
    , _PipelineStages :: [StageDeclaration]
    , _PipelineName :: Maybe Text
    , _PipelineRestartExecutionOnUpdate :: Maybe Bool
    , _PipelineDisableInboundStageTransitions :: Maybe [StageTransition]
    , _PipelineRoleArn :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''ArtifactStore)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''OutputArtifact)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''StageDeclaration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''StageTransition)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''EncryptionKey)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''ActionTypeId)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''BlockerDeclaration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''ActionDeclaration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''InputArtifact)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Pipeline)

resourceJSON :: Pipeline -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CodePipeline::Pipeline" :: Text), "Properties" .= a ]
