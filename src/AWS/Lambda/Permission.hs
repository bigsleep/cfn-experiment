{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Lambda.Permission
    ( Permission(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Permission = Permission
    { _PermissionSourceAccount :: Maybe Text
    , _PermissionEventSourceToken :: Maybe Text
    , _PermissionSourceArn :: Maybe Text
    , _PermissionAction :: Text
    , _PermissionPrincipal :: Text
    , _PermissionFunctionName :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''Permission)

resourceJSON :: Permission -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Lambda::Permission" :: Text), "Properties" .= a ]
