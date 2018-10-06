{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.GuardDuty.Member
    ( Member(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Member = Member
    { _MemberStatus :: Maybe Text
    , _MemberEmail :: Text
    , _MemberMemberId :: Text
    , _MemberDetectorId :: Text
    , _MemberDisableEmailNotification :: Maybe Bool
    , _MemberMessage :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Member)

resourceJSON :: Member -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::GuardDuty::Member" :: Text), "Properties" .= a ]
