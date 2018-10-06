{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ElasticLoadBalancingV2.Listener
    ( Certificate(..)
    , Action(..)
    , Listener(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Certificate = Certificate
    { _CertificateCertificateArn :: Maybe Text
    } deriving (Show, Eq)

data Action = Action
    { _ActionTargetGroupArn :: Text
    , _ActionType :: Text
    } deriving (Show, Eq)

data Listener = Listener
    { _ListenerSslPolicy :: Maybe Text
    , _ListenerProtocol :: Text
    , _ListenerDefaultActions :: [Action]
    , _ListenerCertificates :: Maybe [Certificate]
    , _ListenerLoadBalancerArn :: Text
    , _ListenerPort :: Int
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Certificate)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Action)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Listener)

resourceJSON :: Listener -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ElasticLoadBalancingV2::Listener" :: Text), "Properties" .= a ]
