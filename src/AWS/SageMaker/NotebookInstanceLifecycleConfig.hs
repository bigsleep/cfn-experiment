{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SageMaker.NotebookInstanceLifecycleConfig
    ( NotebookInstanceLifecycleHook(..)
    , NotebookInstanceLifecycleConfig(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data NotebookInstanceLifecycleHook = NotebookInstanceLifecycleHook
    { _NotebookInstanceLifecycleHookContent :: Maybe Text
    } deriving (Show, Eq)

data NotebookInstanceLifecycleConfig = NotebookInstanceLifecycleConfig
    { _NotebookInstanceLifecycleConfigOnCreate :: Maybe [NotebookInstanceLifecycleHook]
    , _NotebookInstanceLifecycleConfigOnStart :: Maybe [NotebookInstanceLifecycleHook]
    , _NotebookInstanceLifecycleConfigNotebookInstanceLifecycleConfigName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''NotebookInstanceLifecycleHook)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 32 } ''NotebookInstanceLifecycleConfig)

resourceJSON :: NotebookInstanceLifecycleConfig -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SageMaker::NotebookInstanceLifecycleConfig" :: Text), "Properties" .= a ]
