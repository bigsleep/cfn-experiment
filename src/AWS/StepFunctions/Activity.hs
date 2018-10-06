{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.StepFunctions.Activity
    ( Activity(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Activity = Activity
    { _ActivityName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Activity)

resourceJSON :: Activity -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::StepFunctions::Activity" :: Text), "Properties" .= a ]
