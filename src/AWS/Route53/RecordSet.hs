{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Route53.RecordSet
    ( GeoLocation(..)
    , AliasTarget(..)
    , RecordSet(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data GeoLocation = GeoLocation
    { _GeoLocationSubdivisionCode :: Maybe Text
    , _GeoLocationCountryCode :: Maybe Text
    , _GeoLocationContinentCode :: Maybe Text
    } deriving (Show, Eq)

data AliasTarget = AliasTarget
    { _AliasTargetHostedZoneId :: Text
    , _AliasTargetEvaluateTargetHealth :: Maybe Bool
    , _AliasTargetDNSName :: Text
    } deriving (Show, Eq)

data RecordSet = RecordSet
    { _RecordSetTTL :: Maybe Text
    , _RecordSetResourceRecords :: Maybe [Text]
    , _RecordSetAliasTarget :: Maybe AliasTarget
    , _RecordSetHostedZoneId :: Maybe Text
    , _RecordSetHostedZoneName :: Maybe Text
    , _RecordSetWeight :: Maybe Int
    , _RecordSetSetIdentifier :: Maybe Text
    , _RecordSetFailover :: Maybe Text
    , _RecordSetName :: Text
    , _RecordSetHealthCheckId :: Maybe Text
    , _RecordSetRegion :: Maybe Text
    , _RecordSetType :: Text
    , _RecordSetGeoLocation :: Maybe GeoLocation
    , _RecordSetComment :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''GeoLocation)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''AliasTarget)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''RecordSet)

resourceJSON :: RecordSet -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Route53::RecordSet" :: Text), "Properties" .= a ]
