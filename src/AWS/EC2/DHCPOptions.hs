{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.DHCPOptions
    ( DHCPOptions(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data DHCPOptions = DHCPOptions
    { _DHCPOptionsNetbiosNodeType :: Maybe Int
    , _DHCPOptionsNetbiosNameServers :: Maybe [Text]
    , _DHCPOptionsNtpServers :: Maybe [Text]
    , _DHCPOptionsDomainName :: Maybe Text
    , _DHCPOptionsTags :: Maybe [Tag]
    , _DHCPOptionsDomainNameServers :: Maybe [Text]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''DHCPOptions)

resourceJSON :: DHCPOptions -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::DHCPOptions" :: Text), "Properties" .= a ]
