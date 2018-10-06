{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SageMaker.NotebookInstance
    ( NotebookInstance(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data NotebookInstance = NotebookInstance
    { _NotebookInstanceNotebookInstanceName :: Maybe Text
    , _NotebookInstanceSecurityGroupIds :: Maybe [Text]
    , _NotebookInstanceLifecycleConfigName :: Maybe Text
    , _NotebookInstanceSubnetId :: Maybe Text
    , _NotebookInstanceInstanceType :: Text
    , _NotebookInstanceKmsKeyId :: Maybe Text
    , _NotebookInstanceDirectInternetAccess :: Maybe Text
    , _NotebookInstanceTags :: Maybe [Tag]
    , _NotebookInstanceRoleArn :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''NotebookInstance)

resourceJSON :: NotebookInstance -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SageMaker::NotebookInstance" :: Text), "Properties" .= a ]
