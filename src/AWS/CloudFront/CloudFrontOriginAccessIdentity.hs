{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CloudFront.CloudFrontOriginAccessIdentity
    ( CloudFrontOriginAccessIdentityConfig(..)
    , CloudFrontOriginAccessIdentity(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data CloudFrontOriginAccessIdentityConfig = CloudFrontOriginAccessIdentityConfig
    { _CloudFrontOriginAccessIdentityConfigComment :: Text
    } deriving (Show, Eq)

data CloudFrontOriginAccessIdentity = CloudFrontOriginAccessIdentity
    { _CloudFrontOriginAccessIdentityCloudFrontOriginAccessIdentityConfig :: CloudFrontOriginAccessIdentityConfig
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 37 } ''CloudFrontOriginAccessIdentityConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 31 } ''CloudFrontOriginAccessIdentity)

resourceJSON :: CloudFrontOriginAccessIdentity -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CloudFront::CloudFrontOriginAccessIdentity" :: Text), "Properties" .= a ]
