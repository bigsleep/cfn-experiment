{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Config.AggregationAuthorization
    ( AggregationAuthorization(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data AggregationAuthorization = AggregationAuthorization
    { _AggregationAuthorizationAuthorizedAwsRegion :: Text
    , _AggregationAuthorizationAuthorizedAccountId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 25 } ''AggregationAuthorization)

resourceJSON :: AggregationAuthorization -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Config::AggregationAuthorization" :: Text), "Properties" .= a ]
