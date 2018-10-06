{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Inspector.AssessmentTarget
    ( AssessmentTarget(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data AssessmentTarget = AssessmentTarget
    { _AssessmentTargetAssessmentTargetName :: Maybe Text
    , _AssessmentTargetResourceGroupArn :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''AssessmentTarget)

resourceJSON :: AssessmentTarget -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Inspector::AssessmentTarget" :: Text), "Properties" .= a ]
