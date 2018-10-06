{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IAM.InstanceProfile
    ( InstanceProfile(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data InstanceProfile = InstanceProfile
    { _InstanceProfileRoles :: [Text]
    , _InstanceProfilePath :: Maybe Text
    , _InstanceProfileInstanceProfileName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''InstanceProfile)

resourceJSON :: InstanceProfile -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IAM::InstanceProfile" :: Text), "Properties" .= a ]
