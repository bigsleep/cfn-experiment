{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.WAF.IPSet
    ( IPSetDescriptor(..)
    , IPSet(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data IPSetDescriptor = IPSetDescriptor
    { _IPSetDescriptorValue :: Text
    , _IPSetDescriptorType :: Text
    } deriving (Show, Eq)

data IPSet = IPSet
    { _IPSetName :: Text
    , _IPSetIPSetDescriptors :: Maybe [IPSetDescriptor]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''IPSetDescriptor)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''IPSet)

resourceJSON :: IPSet -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::WAF::IPSet" :: Text), "Properties" .= a ]
