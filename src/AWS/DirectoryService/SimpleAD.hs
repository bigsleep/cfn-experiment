{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.DirectoryService.SimpleAD
    ( VpcSettings(..)
    , SimpleAD(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VpcSettings = VpcSettings
    { _VpcSettingsSubnetIds :: [Text]
    , _VpcSettingsVpcId :: Text
    } deriving (Show, Eq)

data SimpleAD = SimpleAD
    { _SimpleADCreateAlias :: Maybe Bool
    , _SimpleADShortName :: Maybe Text
    , _SimpleADSize :: Text
    , _SimpleADEnableSso :: Maybe Bool
    , _SimpleADName :: Text
    , _SimpleADPassword :: Text
    , _SimpleADVpcSettings :: VpcSettings
    , _SimpleADDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''VpcSettings)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''SimpleAD)

resourceJSON :: SimpleAD -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::DirectoryService::SimpleAD" :: Text), "Properties" .= a ]
