{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Route53.HostedZone
    ( VPC(..)
    , QueryLoggingConfig(..)
    , HostedZoneTag(..)
    , HostedZoneConfig(..)
    , HostedZone(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VPC = VPC
    { _VPCVPCRegion :: Text
    , _VPCVPCId :: Text
    } deriving (Show, Eq)

data QueryLoggingConfig = QueryLoggingConfig
    { _QueryLoggingConfigCloudWatchLogsLogGroupArn :: Text
    } deriving (Show, Eq)

data HostedZoneTag = HostedZoneTag
    { _HostedZoneTagValue :: Text
    , _HostedZoneTagKey :: Text
    } deriving (Show, Eq)

data HostedZoneConfig = HostedZoneConfig
    { _HostedZoneConfigComment :: Maybe Text
    } deriving (Show, Eq)

data HostedZone = HostedZone
    { _HostedZoneQueryLoggingConfig :: Maybe QueryLoggingConfig
    , _HostedZoneVPCs :: Maybe [VPC]
    , _HostedZoneName :: Text
    , _HostedZoneHostedZoneConfig :: Maybe HostedZoneConfig
    , _HostedZoneHostedZoneTags :: Maybe [HostedZoneTag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 4 } ''VPC)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''QueryLoggingConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''HostedZoneTag)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''HostedZoneConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''HostedZone)

resourceJSON :: HostedZone -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Route53::HostedZone" :: Text), "Properties" .= a ]
