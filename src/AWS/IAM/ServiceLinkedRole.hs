{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IAM.ServiceLinkedRole
    ( ServiceLinkedRole(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ServiceLinkedRole = ServiceLinkedRole
    { _ServiceLinkedRoleCustomSuffix :: Maybe Text
    , _ServiceLinkedRoleAWSServiceName :: Text
    , _ServiceLinkedRoleDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''ServiceLinkedRole)

resourceJSON :: ServiceLinkedRole -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IAM::ServiceLinkedRole" :: Text), "Properties" .= a ]
