{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SSM.Parameter
    ( Parameter(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Parameter = Parameter
    { _ParameterValue :: Text
    , _ParameterName :: Maybe Text
    , _ParameterAllowedPattern :: Maybe Text
    , _ParameterType :: Text
    , _ParameterDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Parameter)

resourceJSON :: Parameter -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SSM::Parameter" :: Text), "Properties" .= a ]
