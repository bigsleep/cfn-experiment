{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.EC2.FlowLog
    ( FlowLog(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data FlowLog = FlowLog
    { _FlowLogResourceId :: Text
    , _FlowLogResourceType :: Text
    , _FlowLogTrafficType :: Text
    , _FlowLogLogDestination :: Maybe Text
    , _FlowLogLogGroupName :: Maybe Text
    , _FlowLogDeliverLogsPermissionArn :: Maybe Text
    , _FlowLogLogDestinationType :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''FlowLog)

resourceJSON :: FlowLog -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::EC2::FlowLog" :: Text), "Properties" .= a ]
