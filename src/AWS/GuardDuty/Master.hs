{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.GuardDuty.Master
    ( Master(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Master = Master
    { _MasterMasterId :: Text
    , _MasterInvitationId :: Maybe Text
    , _MasterDetectorId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Master)

resourceJSON :: Master -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::GuardDuty::Master" :: Text), "Properties" .= a ]
