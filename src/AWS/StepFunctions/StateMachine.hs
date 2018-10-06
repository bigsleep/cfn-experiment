{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.StepFunctions.StateMachine
    ( StateMachine(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data StateMachine = StateMachine
    { _StateMachineStateMachineName :: Maybe Text
    , _StateMachineDefinitionString :: Text
    , _StateMachineRoleArn :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''StateMachine)

resourceJSON :: StateMachine -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::StepFunctions::StateMachine" :: Text), "Properties" .= a ]
