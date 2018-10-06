{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.OpsWorks.ElasticLoadBalancerAttachment
    ( ElasticLoadBalancerAttachment(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ElasticLoadBalancerAttachment = ElasticLoadBalancerAttachment
    { _ElasticLoadBalancerAttachmentElasticLoadBalancerName :: Text
    , _ElasticLoadBalancerAttachmentLayerId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''ElasticLoadBalancerAttachment)

resourceJSON :: ElasticLoadBalancerAttachment -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::OpsWorks::ElasticLoadBalancerAttachment" :: Text), "Properties" .= a ]
