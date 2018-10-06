{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ServiceCatalog.LaunchNotificationConstraint
    ( LaunchNotificationConstraint(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data LaunchNotificationConstraint = LaunchNotificationConstraint
    { _LaunchNotificationConstraintPortfolioId :: Text
    , _LaunchNotificationConstraintNotificationArns :: [Text]
    , _LaunchNotificationConstraintAcceptLanguage :: Maybe Text
    , _LaunchNotificationConstraintDescription :: Maybe Text
    , _LaunchNotificationConstraintProductId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 29 } ''LaunchNotificationConstraint)

resourceJSON :: LaunchNotificationConstraint -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ServiceCatalog::LaunchNotificationConstraint" :: Text), "Properties" .= a ]
