{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.WAFRegional.WebACLAssociation
    ( WebACLAssociation(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data WebACLAssociation = WebACLAssociation
    { _WebACLAssociationWebACLId :: Text
    , _WebACLAssociationResourceArn :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''WebACLAssociation)

resourceJSON :: WebACLAssociation -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::WAFRegional::WebACLAssociation" :: Text), "Properties" .= a ]
