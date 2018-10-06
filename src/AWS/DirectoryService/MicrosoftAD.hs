{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.DirectoryService.MicrosoftAD
    ( VpcSettings(..)
    , MicrosoftAD(..)
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

data MicrosoftAD = MicrosoftAD
    { _MicrosoftADEdition :: Maybe Text
    , _MicrosoftADCreateAlias :: Maybe Bool
    , _MicrosoftADShortName :: Maybe Text
    , _MicrosoftADEnableSso :: Maybe Bool
    , _MicrosoftADName :: Text
    , _MicrosoftADPassword :: Text
    , _MicrosoftADVpcSettings :: VpcSettings
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''VpcSettings)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''MicrosoftAD)

resourceJSON :: MicrosoftAD -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::DirectoryService::MicrosoftAD" :: Text), "Properties" .= a ]
