{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ServiceCatalog.LaunchRoleConstraint
    ( LaunchRoleConstraint(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data LaunchRoleConstraint = LaunchRoleConstraint
    { _LaunchRoleConstraintPortfolioId :: Text
    , _LaunchRoleConstraintAcceptLanguage :: Maybe Text
    , _LaunchRoleConstraintDescription :: Maybe Text
    , _LaunchRoleConstraintProductId :: Text
    , _LaunchRoleConstraintRoleArn :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''LaunchRoleConstraint)

resourceJSON :: LaunchRoleConstraint -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ServiceCatalog::LaunchRoleConstraint" :: Text), "Properties" .= a ]
