{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Glue.DevEndpoint
    ( DevEndpoint(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data DevEndpoint = DevEndpoint
    { _DevEndpointEndpointName :: Maybe Text
    , _DevEndpointExtraPythonLibsS3Path :: Maybe Text
    , _DevEndpointSecurityGroupIds :: Maybe [Text]
    , _DevEndpointPublicKey :: Text
    , _DevEndpointSubnetId :: Maybe Text
    , _DevEndpointNumberOfNodes :: Maybe Int
    , _DevEndpointExtraJarsS3Path :: Maybe Text
    , _DevEndpointRoleArn :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''DevEndpoint)

resourceJSON :: DevEndpoint -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Glue::DevEndpoint" :: Text), "Properties" .= a ]
