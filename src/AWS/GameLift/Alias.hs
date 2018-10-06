{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.GameLift.Alias
    ( RoutingStrategy(..)
    , Alias(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data RoutingStrategy = RoutingStrategy
    { _RoutingStrategyType :: Text
    , _RoutingStrategyMessage :: Maybe Text
    , _RoutingStrategyFleetId :: Maybe Text
    } deriving (Show, Eq)

data Alias = Alias
    { _AliasRoutingStrategy :: RoutingStrategy
    , _AliasName :: Text
    , _AliasDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''RoutingStrategy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Alias)

resourceJSON :: Alias -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::GameLift::Alias" :: Text), "Properties" .= a ]
