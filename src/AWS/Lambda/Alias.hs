{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Lambda.Alias
    ( AliasRoutingConfiguration(..)
    , VersionWeight(..)
    , Alias(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data AliasRoutingConfiguration = AliasRoutingConfiguration
    { _AliasRoutingConfigurationAdditionalVersionWeights :: [VersionWeight]
    } deriving (Show, Eq)

data VersionWeight = VersionWeight
    { _VersionWeightFunctionWeight :: Double
    , _VersionWeightFunctionVersion :: Text
    } deriving (Show, Eq)

data Alias = Alias
    { _AliasRoutingConfig :: Maybe AliasRoutingConfiguration
    , _AliasName :: Text
    , _AliasFunctionName :: Text
    , _AliasFunctionVersion :: Text
    , _AliasDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''AliasRoutingConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''VersionWeight)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Alias)

resourceJSON :: Alias -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Lambda::Alias" :: Text), "Properties" .= a ]
