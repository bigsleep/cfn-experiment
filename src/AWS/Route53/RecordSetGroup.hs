{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Route53.RecordSetGroup
    ( AliasTarget(..)
    , RecordSet(..)
    , GeoLocation(..)
    , RecordSetGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

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

data GeoLocation = GeoLocation
    { _GeoLocationSubdivisionCode :: Maybe Text
    , _GeoLocationCountryCode :: Maybe Text
    , _GeoLocationContinentCode :: Maybe Text
    } deriving (Show, Eq)

data RecordSetGroup = RecordSetGroup
    { _RecordSetGroupRecordSets :: Maybe [RecordSet]
    , _RecordSetGroupHostedZoneId :: Maybe Text
    , _RecordSetGroupHostedZoneName :: Maybe Text
    , _RecordSetGroupComment :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''AliasTarget)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''RecordSet)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''GeoLocation)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''RecordSetGroup)

resourceJSON :: RecordSetGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Route53::RecordSetGroup" :: Text), "Properties" .= a ]
