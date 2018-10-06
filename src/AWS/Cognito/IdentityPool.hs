{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Cognito.IdentityPool
    ( CognitoStreams(..)
    , PushSync(..)
    , CognitoIdentityProvider(..)
    , IdentityPool(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data CognitoStreams = CognitoStreams
    { _CognitoStreamsStreamingStatus :: Maybe Text
    , _CognitoStreamsStreamName :: Maybe Text
    , _CognitoStreamsRoleArn :: Maybe Text
    } deriving (Show, Eq)

data PushSync = PushSync
    { _PushSyncApplicationArns :: Maybe [Text]
    , _PushSyncRoleArn :: Maybe Text
    } deriving (Show, Eq)

data CognitoIdentityProvider = CognitoIdentityProvider
    { _CognitoIdentityProviderClientId :: Maybe Text
    , _CognitoIdentityProviderServerSideTokenCheck :: Maybe Bool
    , _CognitoIdentityProviderProviderName :: Maybe Text
    } deriving (Show, Eq)

data IdentityPool = IdentityPool
    { _IdentityPoolSamlProviderARNs :: Maybe [Text]
    , _IdentityPoolSupportedLoginProviders :: Maybe DA.Value
    , _IdentityPoolIdentityPoolName :: Maybe Text
    , _IdentityPoolDeveloperProviderName :: Maybe Text
    , _IdentityPoolCognitoEvents :: Maybe DA.Value
    , _IdentityPoolCognitoStreams :: Maybe CognitoStreams
    , _IdentityPoolOpenIdConnectProviderARNs :: Maybe [Text]
    , _IdentityPoolCognitoIdentityProviders :: Maybe [CognitoIdentityProvider]
    , _IdentityPoolAllowUnauthenticatedIdentities :: Bool
    , _IdentityPoolPushSync :: Maybe PushSync
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''CognitoStreams)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''PushSync)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 24 } ''CognitoIdentityProvider)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''IdentityPool)

resourceJSON :: IdentityPool -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Cognito::IdentityPool" :: Text), "Properties" .= a ]
