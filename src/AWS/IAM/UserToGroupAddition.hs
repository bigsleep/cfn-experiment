{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IAM.UserToGroupAddition
    ( UserToGroupAddition(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data UserToGroupAddition = UserToGroupAddition
    { _UserToGroupAdditionUsers :: [Text]
    , _UserToGroupAdditionGroupName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''UserToGroupAddition)

resourceJSON :: UserToGroupAddition -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IAM::UserToGroupAddition" :: Text), "Properties" .= a ]
