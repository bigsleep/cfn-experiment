{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SSM.Association
    ( InstanceAssociationOutputLocation(..)
    , ParameterValues(..)
    , S3OutputLocation(..)
    , Target(..)
    , Association(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data InstanceAssociationOutputLocation = InstanceAssociationOutputLocation
    { _InstanceAssociationOutputLocationS3Location :: Maybe S3OutputLocation
    } deriving (Show, Eq)

data ParameterValues = ParameterValues
    { _ParameterValuesParameterValues :: [Text]
    } deriving (Show, Eq)

data S3OutputLocation = S3OutputLocation
    { _S3OutputLocationOutputS3KeyPrefix :: Maybe Text
    , _S3OutputLocationOutputS3BucketName :: Maybe Text
    } deriving (Show, Eq)

data Target = Target
    { _TargetValues :: [Text]
    , _TargetKey :: Text
    } deriving (Show, Eq)

data Association = Association
    { _AssociationInstanceId :: Maybe Text
    , _AssociationScheduleExpression :: Maybe Text
    , _AssociationName :: Text
    , _AssociationOutputLocation :: Maybe InstanceAssociationOutputLocation
    , _AssociationTargets :: Maybe [Target]
    , _AssociationParameters :: Maybe Map
    , _AssociationDocumentVersion :: Maybe Text
    , _AssociationAssociationName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 34 } ''InstanceAssociationOutputLocation)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''ParameterValues)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''S3OutputLocation)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Target)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Association)

resourceJSON :: Association -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SSM::Association" :: Text), "Properties" .= a ]
