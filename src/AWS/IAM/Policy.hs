{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.IAM.Policy
    ( Policy(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Policy = Policy
    { _PolicyGroups :: Maybe [Text]
    , _PolicyPolicyDocument :: DA.Value
    , _PolicyRoles :: Maybe [Text]
    , _PolicyPolicyName :: Text
    , _PolicyUsers :: Maybe [Text]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Policy)

resourceJSON :: Policy -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::IAM::Policy" :: Text), "Properties" .= a ]
