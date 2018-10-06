{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.GameLift.Build
    ( S3Location(..)
    , Build(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data S3Location = S3Location
    { _S3LocationBucket :: Text
    , _S3LocationKey :: Text
    , _S3LocationRoleArn :: Text
    } deriving (Show, Eq)

data Build = Build
    { _BuildStorageLocation :: Maybe S3Location
    , _BuildName :: Maybe Text
    , _BuildVersion :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''S3Location)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Build)

resourceJSON :: Build -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::GameLift::Build" :: Text), "Properties" .= a ]
