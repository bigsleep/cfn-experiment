{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Inspector.AssessmentTemplate
    ( AssessmentTemplate(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data AssessmentTemplate = AssessmentTemplate
    { _AssessmentTemplateAssessmentTargetArn :: Text
    , _AssessmentTemplateUserAttributesForFindings :: Maybe [Tag]
    , _AssessmentTemplateRulesPackageArns :: [Text]
    , _AssessmentTemplateAssessmentTemplateName :: Maybe Text
    , _AssessmentTemplateDurationInSeconds :: Int
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''AssessmentTemplate)

resourceJSON :: AssessmentTemplate -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Inspector::AssessmentTemplate" :: Text), "Properties" .= a ]
