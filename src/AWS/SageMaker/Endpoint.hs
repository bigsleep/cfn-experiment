{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SageMaker.Endpoint
    ( Endpoint(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Endpoint = Endpoint
    { _EndpointEndpointName :: Maybe Text
    , _EndpointEndpointConfigName :: Text
    , _EndpointTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Endpoint)

resourceJSON :: Endpoint -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SageMaker::Endpoint" :: Text), "Properties" .= a ]
