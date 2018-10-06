{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.GuardDuty.IPSet
    ( IPSet(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data IPSet = IPSet
    { _IPSetLocation :: Text
    , _IPSetFormat :: Text
    , _IPSetActivate :: Bool
    , _IPSetDetectorId :: Text
    , _IPSetName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''IPSet)

resourceJSON :: IPSet -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::GuardDuty::IPSet" :: Text), "Properties" .= a ]
