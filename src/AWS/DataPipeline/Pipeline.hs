{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.DataPipeline.Pipeline
    ( PipelineObject(..)
    , PipelineTag(..)
    , ParameterValue(..)
    , ParameterObject(..)
    , ParameterAttribute(..)
    , Field(..)
    , Pipeline(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data PipelineObject = PipelineObject
    { _PipelineObjectName :: Text
    , _PipelineObjectId :: Text
    , _PipelineObjectFields :: [Field]
    } deriving (Show, Eq)

data PipelineTag = PipelineTag
    { _PipelineTagValue :: Text
    , _PipelineTagKey :: Text
    } deriving (Show, Eq)

data ParameterValue = ParameterValue
    { _ParameterValueStringValue :: Text
    , _ParameterValueId :: Text
    } deriving (Show, Eq)

data ParameterObject = ParameterObject
    { _ParameterObjectAttributes :: [ParameterAttribute]
    , _ParameterObjectId :: Text
    } deriving (Show, Eq)

data ParameterAttribute = ParameterAttribute
    { _ParameterAttributeStringValue :: Text
    , _ParameterAttributeKey :: Text
    } deriving (Show, Eq)

data Field = Field
    { _FieldRefValue :: Maybe Text
    , _FieldStringValue :: Maybe Text
    , _FieldKey :: Text
    } deriving (Show, Eq)

data Pipeline = Pipeline
    { _PipelinePipelineObjects :: Maybe [PipelineObject]
    , _PipelinePipelineTags :: Maybe [PipelineTag]
    , _PipelineActivate :: Maybe Bool
    , _PipelineParameterObjects :: [ParameterObject]
    , _PipelineName :: Text
    , _PipelineDescription :: Maybe Text
    , _PipelineParameterValues :: Maybe [ParameterValue]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''PipelineObject)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''PipelineTag)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''ParameterValue)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''ParameterObject)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''ParameterAttribute)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Field)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Pipeline)

resourceJSON :: Pipeline -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::DataPipeline::Pipeline" :: Text), "Properties" .= a ]
