{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.Model
    ( Model(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Model = Model
    { _ModelSchema :: Maybe DA.Value
    , _ModelName :: Maybe Text
    , _ModelRestApiId :: Text
    , _ModelDescription :: Maybe Text
    , _ModelContentType :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Model)

resourceJSON :: Model -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::Model" :: Text), "Properties" .= a ]
