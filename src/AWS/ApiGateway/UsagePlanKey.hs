{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.UsagePlanKey
    ( UsagePlanKey(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data UsagePlanKey = UsagePlanKey
    { _UsagePlanKeyKeyType :: Text
    , _UsagePlanKeyKeyId :: Text
    , _UsagePlanKeyUsagePlanId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''UsagePlanKey)

resourceJSON :: UsagePlanKey -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::UsagePlanKey" :: Text), "Properties" .= a ]
