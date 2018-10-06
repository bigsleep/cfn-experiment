{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ECR.Repository
    ( LifecyclePolicy(..)
    , Repository(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data LifecyclePolicy = LifecyclePolicy
    { _LifecyclePolicyRegistryId :: Maybe Text
    , _LifecyclePolicyLifecyclePolicyText :: Maybe Text
    } deriving (Show, Eq)

data Repository = Repository
    { _RepositoryRepositoryPolicyText :: Maybe DA.Value
    , _RepositoryRepositoryName :: Maybe Text
    , _RepositoryLifecyclePolicy :: Maybe LifecyclePolicy
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''LifecyclePolicy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''Repository)

resourceJSON :: Repository -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ECR::Repository" :: Text), "Properties" .= a ]
