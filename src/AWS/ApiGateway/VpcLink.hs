{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ApiGateway.VpcLink
    ( VpcLink(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data VpcLink = VpcLink
    { _VpcLinkTargetArns :: [Text]
    , _VpcLinkName :: Text
    , _VpcLinkDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''VpcLink)

resourceJSON :: VpcLink -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ApiGateway::VpcLink" :: Text), "Properties" .= a ]
