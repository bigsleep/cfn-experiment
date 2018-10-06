{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.OpsWorks.Stack
    ( ElasticIp(..)
    , Source(..)
    , ChefConfiguration(..)
    , StackConfigurationManager(..)
    , RdsDbInstance(..)
    , Stack(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ElasticIp = ElasticIp
    { _ElasticIpIp :: Text
    , _ElasticIpName :: Maybe Text
    } deriving (Show, Eq)

data Source = Source
    { _SourceUrl :: Maybe Text
    , _SourceUsername :: Maybe Text
    , _SourceSshKey :: Maybe Text
    , _SourcePassword :: Maybe Text
    , _SourceType :: Maybe Text
    , _SourceRevision :: Maybe Text
    } deriving (Show, Eq)

data ChefConfiguration = ChefConfiguration
    { _ChefConfigurationBerkshelfVersion :: Maybe Text
    , _ChefConfigurationManageBerkshelf :: Maybe Bool
    } deriving (Show, Eq)

data StackConfigurationManager = StackConfigurationManager
    { _StackConfigurationManagerName :: Maybe Text
    , _StackConfigurationManagerVersion :: Maybe Text
    } deriving (Show, Eq)

data RdsDbInstance = RdsDbInstance
    { _RdsDbInstanceRdsDbInstanceArn :: Text
    , _RdsDbInstanceDbUser :: Text
    , _RdsDbInstanceDbPassword :: Text
    } deriving (Show, Eq)

data Stack = Stack
    { _StackDefaultInstanceProfileArn :: Text
    , _StackCloneAppIds :: Maybe [Text]
    , _StackServiceRoleArn :: Text
    , _StackElasticIps :: Maybe [ElasticIp]
    , _StackEcsClusterArn :: Maybe Text
    , _StackDefaultRootDeviceType :: Maybe Text
    , _StackVpcId :: Maybe Text
    , _StackChefConfiguration :: Maybe ChefConfiguration
    , _StackAgentVersion :: Maybe Text
    , _StackDefaultSshKeyName :: Maybe Text
    , _StackCustomJson :: Maybe DA.Value
    , _StackClonePermissions :: Maybe Bool
    , _StackSourceStackId :: Maybe Text
    , _StackCustomCookbooksSource :: Maybe Source
    , _StackDefaultAvailabilityZone :: Maybe Text
    , _StackAttributes :: Maybe Map
    , _StackName :: Text
    , _StackDefaultOs :: Maybe Text
    , _StackUseOpsworksSecurityGroups :: Maybe Bool
    , _StackUseCustomCookbooks :: Maybe Bool
    , _StackDefaultSubnetId :: Maybe Text
    , _StackConfigurationManager :: Maybe StackConfigurationManager
    , _StackHostnameTheme :: Maybe Text
    , _StackTags :: Maybe [Tag]
    , _StackRdsDbInstances :: Maybe [RdsDbInstance]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''ElasticIp)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Source)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''ChefConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''StackConfigurationManager)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''RdsDbInstance)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Stack)

resourceJSON :: Stack -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::OpsWorks::Stack" :: Text), "Properties" .= a ]
