{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ServiceCatalog.LaunchTemplateConstraint
    ( LaunchTemplateConstraint(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data LaunchTemplateConstraint = LaunchTemplateConstraint
    { _LaunchTemplateConstraintPortfolioId :: Text
    , _LaunchTemplateConstraintRules :: Text
    , _LaunchTemplateConstraintAcceptLanguage :: Maybe Text
    , _LaunchTemplateConstraintDescription :: Maybe Text
    , _LaunchTemplateConstraintProductId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 25 } ''LaunchTemplateConstraint)

resourceJSON :: LaunchTemplateConstraint -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ServiceCatalog::LaunchTemplateConstraint" :: Text), "Properties" .= a ]
