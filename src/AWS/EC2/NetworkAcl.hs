{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.NetworkAcl
    ( NetworkAcl(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data NetworkAcl = NetworkAcl
    { _NetworkAclVpcId :: Text
    , _NetworkAclTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''NetworkAcl)

resourceJSON :: NetworkAcl -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::NetworkAcl" :: Text), "Properties" .= a ]
