{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ElasticBeanstalk.ApplicationVersion
    ( SourceBundle(..)
    , ApplicationVersion(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SourceBundle = SourceBundle
    { _SourceBundleS3Key :: Text
    , _SourceBundleS3Bucket :: Text
    } deriving (Show, Eq)

data ApplicationVersion = ApplicationVersion
    { _ApplicationVersionSourceBundle :: SourceBundle
    , _ApplicationVersionApplicationName :: Text
    , _ApplicationVersionDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''SourceBundle)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''ApplicationVersion)

resourceJSON :: ApplicationVersion -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ElasticBeanstalk::ApplicationVersion" :: Text), "Properties" .= a ]
